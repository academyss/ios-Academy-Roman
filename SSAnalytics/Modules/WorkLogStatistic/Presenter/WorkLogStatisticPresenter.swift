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
    
    private(set) lazy var getSummary = SttComandWithParametr(delegate: self, handler: { $0.onGetStats(dateString: $1) })
    
    let approved = Dynamic<String>("0h 0m")
    let logTime = Dynamic<String>("0h 0m")
    let pending = Dynamic<String>("0h 0m")
    let rejected = Dynamic<String>("0h 0m")
    let totalSalary = Dynamic<String>("0$")
    let rejectedSalary = Dynamic<String>("0$")
       
    let disposeBag = DisposeBag()
    
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
                
                self.approved.value = self.loggedHoursToString(value: value.approved)
                self.logTime.value = self.loggedHoursToString(value: value.loggedTime)
                self.pending.value = self.loggedHoursToString(value: value.pending)
                self.rejected.value = self.loggedHoursToString(value: value.rejected)
                self.totalSalary.value = "\(value.totalSalary)$"
            
        }).disposed(by: disposeBag)
        
    }
    
    func loggedHoursToString(value: Int) -> String {
        let hours = value / 3600
        let minutes = (value - hours * 3600) / 60
        
        return "\(hours)h \(minutes)m"
    }
    
    func formatDate(date: Date?) -> String {
        let dateFormater = DateFormatter()
        dateFormater.dateFormat = "yyyy-MM"
        let formatedDate = dateFormater.string(from: date ?? Date())
        return formatedDate
    }
}
