//
//  WorkLogDiaryRequestApiModel.swift
//  SSAnalytics
//
//  Created by StartupSoft Mac6 on 4/24/19.
//  Copyright © 2019 startupsoft. All rights reserved.
//

import Foundation

enum WorkLogStatuses: Int, Codable {
    case approved = 1, pending, rejected
}

struct WorkLogDiaryRequestApiModel: Codable {
    var startDate: String
    var endDate: String
    var projectsId: [String]
    var workLogStatuses: [WorkLogStatuses]
    
    enum CodingKeys: String, CodingKey {
        case startDate
        case endDate
        case projectsId
        case workLogStatuses
    }
}
