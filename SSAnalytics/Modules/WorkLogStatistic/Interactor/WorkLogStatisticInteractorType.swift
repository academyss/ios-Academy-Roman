//
//  WorkLogStatisticInteractorType.swift
//  SSAnalytics
//
//  Created by StartupSoft Mac6 on 4/22/19.
//  Copyright © 2019 startupsoft. All rights reserved.
//

import Foundation
import RxSwift

protocol WorkLogStatisticInteractorType {
    
    func getWorkLogStatistics(date: String) -> Observable<WorkLogStatisticApiModel>
    
}
