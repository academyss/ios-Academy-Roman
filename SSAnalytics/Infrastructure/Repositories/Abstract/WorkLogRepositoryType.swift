//
//  WorkLogStatistic.swift
//  SSAnalytics
//
//  Created by StartupSoft Mac6 on 4/23/19.
//  Copyright © 2019 startupsoft. All rights reserved.
//

import Foundation
import RxSwift

protocol WorkLogRepositoryType {
    
    func getWorkLogStatistics(date: String) -> Observable<WorkLogStatisticApiModel>
    func getWorkLogDiary(data: WorkLogDiaryRequestApiModel) -> Observable<[WorkLogDiaryResponseApiModel]>
    func getMyProjects(projectName: String) -> Observable<[ProjectApiModel]>
}
