//
//  WorkLogLogTimeInteractor.swift
//  SSAnalytics
//
//  Created by StartupSoft Mac6 on 4/22/19.
//  Copyright © 2019 startupsoft. All rights reserved.
//

import Foundation
import RxSwift
import STT

final class WorkLogLogTimeInteractor: WorkLogLogTimeInteractorType {
    
    private let _workLogRepository: WorkLogRepositoryType
    private let _notificationErrorService: SttNotificationErrorServiceType
    
    init(workLogRepository: WorkLogRepositoryType, notificationErrorService: SttNotificationErrorServiceType) {
        _workLogRepository = workLogRepository
        _notificationErrorService = notificationErrorService
    }
    
    func getWorkLogDiary(data: WorkLogDiaryRequestApiModel) -> Observable<[(SttObservableCollection<WorkLogTimeTableViewCellPresenter>, WorkLogTimeViewSectionPresenter)]> {
        return _workLogRepository.getWorkLogDiary(data: data)
            .map({ $0.convertToViewModel() })
    }
}
