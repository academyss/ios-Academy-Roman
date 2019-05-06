 //
 //  WorkLogPresenter.swift
 //  SSAnalytics
 //
 //  Created by StartupSoft Mac6 on 4/22/19.
 //  Copyright © 2019 startupsoft. All rights reserved.
 //
 
 import Foundation
 import STT
 
 final class WorkLogPresenter: SttPresenter<WorkLogViewDelegate> {
    
    private let _router: WorkLogRouterType
    private let _interactor: WorkLogInteractorType
    
    let segment = Dynamic<Int>(0)
    private(set) lazy var showFilter = SttCommand(delegate: self, handler: { $0.onFilter() })
    var filterObject = WorkLogDiaryRequestApiModel(startDate: "", endDate: "", projectsId: [], workLogStatuses: [])
    
    init(view: SttViewable, notificationService: SttNotificationErrorServiceType, router: WorkLogRouterType,
         interactor: WorkLogInteractorType) {
        
        _router = router
        _interactor = interactor
        
        super.init(notificationError: notificationService)
        super.injectView(delegate: view)
    }
    
    func onFilter() {
        _router.navigateWithId(to: WorkLogFilterPresenter.self,
                               parametr: { [weak self] (data: WorkLogDiaryRequestApiModel) in
                                self?.filterObject = data
                                self?.delegate?.goToLogTime(param: self!.filterObject)
            },  typeNavigation: .push, animate: true)
    }
 }
