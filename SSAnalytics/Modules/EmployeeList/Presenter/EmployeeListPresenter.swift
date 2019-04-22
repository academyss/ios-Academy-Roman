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
    
    private(set) lazy var download: SttCommand = SttCommand(delegate: self, handler: { $0.onDownload() })
    
    var employeesCollection = SttObservableCollection<CellTableViewCellPresenter>()
    let disposeBag = DisposeBag()
    
    var searchString: Dynamic<String?> = Dynamic("")
    
   
    
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
        }
        
    }
    
    func onDownload() {
        _interactor.getUsersByInput(input: searchString.value ?? "")
            .useWork(download)
            .delaySubscription(1, scheduler: MainScheduler.instance)
            .subscribe(onNext: { [unowned self] users in
                self.employeesCollection.removeAll()
                self.employeesCollection.append(contentsOf: users)
                self.employeesCollection.forEach({ $0.parent = self })
            }).disposed(by: disposeBag)
    }
    
    func navigate(user: EmployeeApiModel) {
        _router.navigateWithId(to: ProfileInfoPresenter.self, parametr: user, typeNavigation: .push, animate: true)
    }
    
    func updateTableView() {
        delegate?.updateTableView()
    }
}
