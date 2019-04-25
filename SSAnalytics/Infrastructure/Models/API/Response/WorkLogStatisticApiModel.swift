//
//  WorkLogStatisticApiModel.swift
//  SSAnalytics
//
//  Created by StartupSoft Mac6 on 4/22/19.
//  Copyright © 2019 startupsoft. All rights reserved.
//

import Foundation


struct WorkLogStatisticApiModel: Codable {
    
    var approved: Int
    var rejected: Int
    var pending: Int
    var loggedTime: Int
    var totalSalary: Double

}
