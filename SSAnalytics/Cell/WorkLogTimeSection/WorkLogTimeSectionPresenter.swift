//
//  WorkLogTimeSectionPresenter.swift
//  SSAnalytics
//
//  Created by StartupSoft Mac6 on 4/24/19.
//  Copyright © 2019 startupsoft. All rights reserved.
//

import Foundation
import STT

class WorkLogTimeViewSectionPresenter: SttPresenter<SttViewable> {
    
    weak var parent: WorkLogTimeSectionDelegate!
    
    let day: Dynamic<String>
    let spendedTime: Dynamic<String>

    
    init (day: String, spendedTime: String ) {
        
        self.day = Dynamic(day)
        self.spendedTime = Dynamic(spendedTime)

        super.init(notificationError: nil)
    }
    
}
