//
//  EmployeeListPresenter.swift
//  SSAnalytics
//
//  Created by StartupSoft Mac6 on 4/5/19.
//  Copyright © 2019 startupsoft. All rights reserved.
//

import Foundation
import STT

final class EmployeeListPresenter: SttPresenter<EmployeeListViewDelegate> {
    
    private let _router: EmployeeListRouterType
    private let _interactor: EmployeeListInteractorType
    
    var employeesCollection = SttObservableCollection<CellTableViewCellPresenter>()
    var searchString: String? {
        didSet {
            
        }
    }
    
    init(view: SttViewable, notificationService: SttNotificationErrorServiceType, router: EmployeeListRouterType,
         interactor: EmployeeListInteractorType) {
        
        _router = router
		_interactor = interactor
        
        super.init(notificationError: notificationService)
        super.injectView(delegate: view)
    }
  
}
