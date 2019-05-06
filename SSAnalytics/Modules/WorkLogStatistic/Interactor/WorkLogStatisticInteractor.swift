//
//  WorkLogStatisticInteractor.swift
//  SSAnalytics
//
//  Created by StartupSoft Mac6 on 4/22/19.
//  Copyright © 2019 startupsoft. All rights reserved.
//

import Foundation
import RxSwift
import STT

final class WorkLogStatisticInteractor: WorkLogStatisticInteractorType {
    
    private let _workLogRepository: WorkLogRepositoryType
    private let _notificationErrorService: SttNotificationErrorServiceType
    
    init(workLogRepository: WorkLogRepositoryType, notificationErrorService: SttNotificationErrorServiceType) {
        _workLogRepository = workLogRepository
        _notificationErrorService = notificationErrorService
    }
    
    func getWorkLogStatistics(date: String) -> Observable<WorkLogStatisticApiModel> {
        return _workLogRepository.getWorkLogStatistics(date: date)
    }
    
}
