//
//  WorkLogFilterPresenter.swift
//  SSAnalytics
//
//  Created by StartupSoft Mac6 on 4/30/19.
//  Copyright © 2019 startupsoft. All rights reserved.
//

import Foundation
import STT
import RxSwift

typealias WorkLogFilterPresenterClose = (WorkLogDiaryRequestApiModel) -> Void
final class WorkLogFilterPresenter: SttPresenterWithParametr<WorkLogFilterViewDelegate, WorkLogFilterPresenterClose>, ProjectCollectionViewCellDelegate {
    
    private let _router: WorkLogFilterRouterType
    private let _interactor: WorkLogFilterInteractorType
    
    private var closeClosure: WorkLogFilterPresenterClose!
    
    var projects = SttObservableCollection<ProjectCollectionViewCellPresenter>()
    
    let startDate = Dynamic(Date())
    let endDate = Dynamic(Date())
    let approved = Dynamic(false)
    let pending = Dynamic(false)
    let rejected = Dynamic(false)
    let isEmpty = Dynamic(true)
    let disposeBag = DisposeBag()
    
    
    private(set) lazy var clear = SttCommand(delegate: self, handler: { $0.onClear() })
    private(set) lazy var close = SttCommand(delegate: self, handler: { $0.onClose() })
    private(set) lazy var addProjects = SttComandWithParametr(delegate: self, handler: { $0.onAddProjects($1) })
    private(set) lazy var filter = SttCommand(delegate: self, handler: { $0.onFilter() })
    
    init(view: SttViewable, notificationService: SttNotificationErrorServiceType, router: WorkLogFilterRouterType,
         interactor: WorkLogFilterInteractorType) {
        
        _router = router
        _interactor = interactor
        
        super.init(notificationError: notificationService)
        super.injectView(delegate: view)
        startDate.addListener({ date in
            self.delegate?.setMinDate(date: date)
            print(date)
        })
    }
    
    private var firstStart = true
    override func viewAppeared() {
        super.viewAppeared()
        
        if firstStart {
            firstStart = false
            
            projects.observableObject
                .subscribe(onNext: { [unowned self] _ in
                    if self.projects.isEmpty {
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3, execute: { self.isEmpty.value = true })
                    } else {
                        self.isEmpty.value = false
                    }
                }).disposed(by: disposeBag)
        }
        
    }
    override func prepare(parametr: @escaping WorkLogFilterPresenterClose) {
        super.prepare(parametr: parametr)
        self.closeClosure = parametr
    }
    
    func onAddProjects(_ projects: [ProjectCollectionViewCellPresenter]){
        self.projects.removeAll()
        self.projects.append(contentsOf: projects)
    }
    
    func onClear() {
        projects.removeAll()
    }
    
    func onClose() {
        _router.close(animate: true)
    }
    
    func deleteObject(id: String) {
        if let index = projects.index(where: { $0.id.value == id }) {
            projects.remove(at: index)
        }
    }
    
    func onFilter() {       
        
        let filterObject = WorkLogDiaryRequestApiModel(startDate: startDate.value.toString(format: "yyyy-MM-dd"), endDate: endDate.value.toString(format: "yyyy-MM-dd"), projectsId: projects.map({ (project) in
            project.id.value
        }), workLogStatuses: getWorkLogStatusesArray() )
        
        closeClosure(filterObject)
        _router.close(animate: true)
        
    }
    
    func getWorkLogStatusesArray() -> [WorkLogStatuses] {
        var workLogStatuses: [WorkLogStatuses] = []
        if approved.value {
            workLogStatuses.append(WorkLogStatuses.approved)
        }
        if rejected.value {
            workLogStatuses.append(WorkLogStatuses.rejected)
        }
        if pending.value {
            workLogStatuses.append(WorkLogStatuses.pending)
        }
        return workLogStatuses
    }
}
