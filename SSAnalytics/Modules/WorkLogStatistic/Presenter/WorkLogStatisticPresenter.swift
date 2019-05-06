//
//  WorkLogStatisticPresenter.swift
//  SSAnalytics
//
//  Created by StartupSoft Mac6 on 4/22/19.
//  Copyright © 2019 startupsoft. All rights reserved.
//

import Foundation
import STT
import RxSwift

final class WorkLogStatisticPresenter: SttPresenter<WorkLogStatisticViewDelegate> {
    
    private let _router: WorkLogStatisticRouterType
    private let _interactor: WorkLogStatisticInteractorType
    
    let approved = Dynamic<Int>(0)
    let logTime = Dynamic<Int>(0)
    let pending = Dynamic<Int>(0)
    let rejected = Dynamic<Int>(0)
    let totalSalary = Dynamic<Double>(0)
    let rejectedSalary = Dynamic<Double>(0)
       
    let disposeBag = DisposeBag()
    
    private(set) lazy var getSummary = SttComandWithParametr(delegate: self, handler: { $0.onGetStats(dateString: $1) })

    
    init(view: SttViewable, notificationService: SttNotificationErrorServiceType, router: WorkLogStatisticRouterType,
         interactor: WorkLogStatisticInteractorType) {
        
        _router = router
		_interactor = interactor
        
        super.init(notificationError: notificationService)
        super.injectView(delegate: view)
    }
    
        
    func onGetStats(dateString: String?) {
        _interactor.getWorkLogStatistics(date: dateString!)
            .useWork(getSummary)
            .subscribe(onNext: { [unowned self] value in
                
                self.approved.value = value.approved
                self.logTime.value = value.loggedTime
                self.pending.value = value.pending
                self.rejected.value = value.rejected
                self.totalSalary.value = value.totalSalary
            
                }, onError: { [unowned self] error in
                    if let err = error as? SttBaseError {
                        self.delegate?.sendError(error: err)
                    }                    
            }).disposed(by: disposeBag)
        
    }  
    
}
