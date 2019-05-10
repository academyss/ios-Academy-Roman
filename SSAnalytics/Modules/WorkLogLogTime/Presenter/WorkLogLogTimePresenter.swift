//
//  WorkLogLogTimePresenter.swift
//  SSAnalytics
//
//  Created by StartupSoft Mac6 on 4/22/19.
//  Copyright © 2019 startupsoft. All rights reserved.
//

import Foundation
import STT
import RxSwift

final class WorkLogLogTimePresenter: SttPresenter<WorkLogLogTimeViewDelegate>, WorkLogTimeTableViewCellDelegate {    
    
    private let _router: WorkLogLogTimeRouterType
    private let _interactor: WorkLogLogTimeInteractorType
    
    
    var itemsCollection = SttObservableCollection<(SttObservableCollection<WorkLogTimeTableViewCellPresenter>, WorkLogTimeViewSectionPresenter)>()
    
    let disposeBag = DisposeBag()
    let filterObject = Dynamic(WorkLogDiaryRequestApiModel(startDate: "", endDate: "", projectsId: [], workLogStatuses: []))
    let isEmpty = Dynamic(true)
    
    private(set) lazy var download: SttCommand = SttCommand(delegate: self, handler: { $0.onDownload() })
    private(set) lazy var refresh = SttCommand(delegate: self, handler: { $0.onRefresh() })

    
    init(view: SttViewable, notificationService: SttNotificationErrorServiceType, router: WorkLogLogTimeRouterType,
         interactor: WorkLogLogTimeInteractorType) {
        
        _router = router
		_interactor = interactor
        
        super.init(notificationError: notificationService)
        super.injectView(delegate: view)
        
        filterObject.addListener({_ in
            print(self.filterObject)
        })
        
    }
    
    private var firstStart = true
    override func viewAppeared() {
        super.viewAppeared()
        
        if firstStart {
            firstStart = false
            
            filterObject.bind { [unowned self] _ in
                self.download.execute()
            }
            
            itemsCollection.observableObject
            .subscribe(onNext: { [unowned self] _ in
                self.isEmpty.value = self.itemsCollection.isEmpty
            }).disposed(by: disposeBag)
        }
        
    }
    
    func onDownload() {
        itemsCollection.removeAll()
        _interactor.getWorkLogDiary(data: filterObject.value)
            .useWork(download)
            .subscribe(onNext: { [unowned self] items in
                self.itemsCollection.append(contentsOf: items)
                self.itemsCollection.forEach({ $0.0.forEach({ $0.parent = self})})
                }, onError: { [unowned self] error in
                    if let err = error as? SttBaseError {
                        self.delegate?.sendError(error: err)
                    }
            }).disposed(by: disposeBag)
    }
    
    func onRefresh() {
        itemsCollection.removeAll()
        _interactor.getWorkLogDiary(data: filterObject.value)
            .useWork(refresh)
            .subscribe(onNext: { [unowned self] items in
                self.itemsCollection.append(contentsOf: items)
                self.itemsCollection.forEach({ $0.0.forEach({ $0.parent = self})})
                }, onError: { [unowned self] error in
                    if let err = error as? SttBaseError {
                        self.delegate?.sendError(error: err)
                    }
            }).disposed(by: disposeBag)
    }
    
    func updateTableView() {
        delegate?.updateTableView()
    }
    func deselectAll(id: String) {
        itemsCollection.forEach({ item in
            item.0.forEach( { i in
                if i.id.value != id {
                    i.isSelected.value = false
                }
            })
        })
    }
}
