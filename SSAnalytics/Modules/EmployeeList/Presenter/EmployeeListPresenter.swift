//
//  EmployeeListPresenter.swift
//  SSAnalytics
//
//  Created by StartupSoft Mac6 on 4/5/19.
//  Copyright © 2019 startupsoft. All rights reserved.
//

import Foundation
import STT
import RxSwift

final class EmployeeListPresenter: SttPresenter<EmployeeListViewDelegate>, CellTableViewCellDelegate {
    
    private let _router: EmployeeListRouterType
    private let _interactor: EmployeeListInteractorType
    
    var employeesCollection = SttObservableCollection<CellTableViewCellPresenter>()
    
    let isEmpty = Dynamic(true)
    let disposeBag = DisposeBag()
    let searchString: Dynamic<String?> = Dynamic("")
    
    private(set) lazy var download: SttCommand = SttCommand(delegate: self, handler: { $0.onDownload() })
    
    
    init(view: SttViewable, notificationService: SttNotificationErrorServiceType, router: EmployeeListRouterType,
         interactor: EmployeeListInteractorType) {
        
        _router = router
        _interactor = interactor
        
        super.init(notificationError: notificationService)
        super.injectView(delegate: view)
    }
    
    private var firstStart = true
    override func viewAppeared() {
        super.viewAppeared()
        
        if firstStart {
            firstStart = false
            
            searchString.bind { [unowned self] _ in
                self.download.execute()
            }
            
            self.employeesCollection.observableObject
                .useWork(download)
                .subscribe(onNext: { [unowned self] _ in
                    self.isEmpty.value = self.employeesCollection.isEmpty
                }).disposed(by: disposeBag)
        }
        
        if employeesCollection.isEmpty {
            self.download.execute()
        }        
    }
    
    override func viewAppearing() {
        super.viewAppearing()
        deselectAll()
    }
    
    func onDownload() {
        self.employeesCollection.removeAll()
        _interactor.getUsersByInput(input: searchString.value ?? "")
            .delaySubscription(1, scheduler: MainScheduler.instance)
            .useWork(download)
            .subscribe(onNext: { [unowned self] users in
                self.employeesCollection.append(contentsOf: users)
                self.employeesCollection.forEach({ $0.parent = self })
                }, onError: { [unowned self] error in
                    if let err = error as? SttBaseError {
                        self.delegate?.sendError(error: err)
                    }
            }).disposed(by: disposeBag)
    }
    
    func navigate(user: EmployeeApiModel) {
        _router.navigateWithId(to: ProfileInfoPresenter.self, parametr: user, typeNavigation: .push, animate: true)
    }
    
    func updateTableView() {
        delegate?.updateTableView()
    }
    
    func deselectAll() {
        employeesCollection.forEach({ $0.isSelected.value = false })
        updateTableView()
    }
}
