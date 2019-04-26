//
//  WorkLogTimeCell.swift
//  SSAnalytics
//
//  Created by StartupSoft Mac6 on 4/26/19.
//  Copyright © 2019 startupsoft. All rights reserved.
//

import Foundation
import STT

extension LogItem {
    func convertLogItem() -> WorkLogTimeTableViewCellPresenter {
        return WorkLogTimeTableViewCellPresenter(projectName: self.projectName, spendedTime: String(self.timeSpentSeconds), describtion: self.describtion, startTime: self.startTime, status: String(self.status.getJsonString()))
    }
}

extension Array where Element == LogItem {
    func getAllLoggedTime() -> Int {
        var allTime: Int = 0
        self.forEach { item in
            allTime += item.timeSpentSeconds
        }
        return allTime
    }
}

extension WorkLogDiaryResponseApiModel {
    
    func convertToViewModel() -> (SttObservableCollection<WorkLogTimeTableViewCellPresenter>, WorkLogTimeViewSectionPresenter) {
        return (SttObservableCollection(value.map({ $0.convertLogItem() })), WorkLogTimeViewSectionPresenter(day: key, spendedTime: String(value.getAllLoggedTime()) ))
    }
}

extension Array where Element == WorkLogDiaryResponseApiModel {
    
    func convertToViewModel() -> [(SttObservableCollection<WorkLogTimeTableViewCellPresenter>, WorkLogTimeViewSectionPresenter)] {
        return self.map({ $0.convertToViewModel() })
    }
}
