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

final class EmployeeListPresenter: SttPresenter<EmployeeListViewDelegate> {
    
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
        _interactor.getUsersByInput(input: searchString.value ?? "").useWork(download)
            .subscribe(onNext: { [unowned self] users in
                self.employeesCollection.append(contentsOf: users)
            }).disposed(by: disposeBag)
    }
    
}
