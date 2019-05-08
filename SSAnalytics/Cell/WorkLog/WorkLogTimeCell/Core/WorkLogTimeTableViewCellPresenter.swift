//
//  WorkLogTimeTableViewCellPresenter.swift
//  SSAnalytics
//
//  Created by StartupSoft Mac6 on 4/24/19.
//  Copyright © 2019 startupsoft. All rights reserved.
//

import Foundation
import STT

final class WorkLogTimeTableViewCellPresenter: SttPresenter<WorkLogTimeTableViewCellViewDelegate> {
    
    weak var parent: WorkLogTimeTableViewCellDelegate!
    
    let projectName = Dynamic<String>("")
    let spendedTime = Dynamic<Int>(0)
    let describtion = Dynamic<String>("")
    let startTime = Dynamic<String>("")
    let status = Dynamic<WorkLogStatuses>(WorkLogStatuses.pending)
    let id = Dynamic<String>("")
    let isSelected = Dynamic<Bool>(false)
    
    private(set) lazy var select = SttCommand(delegate: self, handler: { $0.onSelect() })
    
    init(id: String, projectName: String, spendedTime: Int, describtion: String, startTime: String, status: WorkLogStatuses) {
        
        self.projectName.value = projectName
        self.spendedTime.value = spendedTime
        self.describtion.value = describtion
        self.startTime.value = startTime
        self.status.value = status
        self.id.value = id
        
        super.init(notificationError: nil)
    }
    
    func onSelect() {
        parent?.deselectAll(id: id.value)
        isSelected.value.toggle()
        parent.updateTableView()
    }
}
