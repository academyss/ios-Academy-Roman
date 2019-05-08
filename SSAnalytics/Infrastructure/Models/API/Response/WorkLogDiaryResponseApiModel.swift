//
//  WorkLogTimeApiModel.swift
//  SSAnalytics
//
//  Created by StartupSoft Mac6 on 4/24/19.
//  Copyright © 2019 startupsoft. All rights reserved.
//

import Foundation


struct WorkLogDiaryResponseApiModel: Codable {
    var key: String
    var value: [LogItem]
}

struct LogItem: Codable {
    var id: String
    var projectName: String
    var timeSpentSeconds: Int
    var describtion: String
    var startTime: String
    var status: WorkLogStatuses
    
    enum CodingKeys: String, CodingKey {
        case id
        case projectName
        case timeSpentSeconds
        case describtion = "issueSummary"
        case startTime = "started"
        case status
    }
}
