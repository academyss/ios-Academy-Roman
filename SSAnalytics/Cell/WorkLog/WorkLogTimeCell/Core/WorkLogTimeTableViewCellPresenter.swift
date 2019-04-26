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
    let spendedTime = Dynamic<String>("")
    let describtion = Dynamic<String>("")
    let startTime = Dynamic<String>("")
    let status = Dynamic<String>("")
    
    let isSelected = Dynamic<Bool>(true)
    
    private(set) lazy var select = SttCommand(delegate: self, handler: { $0.onSelect() })
    
    init(projectName: String, spendedTime: String, describtion: String, startTime: String, status: String) {
        
        self.projectName.value = projectName
        self.spendedTime.value = spendedTime
        self.describtion.value = describtion
        self.startTime.value = startTime
        self.status.value = status
        
        super.init(notificationError: nil)
    }
    
    func onSelect() {
        print(isSelected.value)
        isSelected.value.toggle()
        parent.updateTableView()
    }
}
