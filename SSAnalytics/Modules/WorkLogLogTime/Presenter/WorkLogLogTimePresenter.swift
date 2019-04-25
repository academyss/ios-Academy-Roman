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

final class WorkLogLogTimePresenter: SttPresenter<WorkLogLogTimeViewDelegate> {
    
    private let _router: WorkLogLogTimeRouterType
    private let _interactor: WorkLogLogTimeInteractorType
    
    private(set) lazy var download: SttCommand = SttCommand(delegate: self, handler: { $0.onDownload() })
    
    var employeesCollection = SttObservableCollection<CellTableViewCellPresenter>()
    let disposeBag = DisposeBag()
    
    init(view: SttViewable, notificationService: SttNotificationErrorServiceType, router: WorkLogLogTimeRouterType,
         interactor: WorkLogLogTimeInteractorType) {
        
        _router = router
		_interactor = interactor
        
        super.init(notificationError: notificationService)
        super.injectView(delegate: view)
    }
    
    func onDownload() {
        
    }
}
