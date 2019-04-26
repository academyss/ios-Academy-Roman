//
//  WorkLogStatistics.swift
//  SSAnalytics
//
//  Created by StartupSoft Mac6 on 4/23/19.
//  Copyright © 2019 startupsoft. All rights reserved.
//

import Foundation
import RxSwift

final class WorkLogRepository: BaseRepository, WorkLogRepositoryType {
    
    func getWorkLogStatistics(date: String) -> Observable<WorkLogStatisticApiModel> {
        return _apiDataProvider.getWorkLogStatistics(date: date)
    }
    
    func getWorkLogDiary(data: WorkLogDiaryRequestApiModel) -> Observable<[WorkLogDiaryResponseApiModel]> {
        return _apiDataProvider.getWorkLogDiary(data: data)
    }
}
