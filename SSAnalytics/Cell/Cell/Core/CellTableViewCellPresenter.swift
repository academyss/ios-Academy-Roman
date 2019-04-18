//
//  CellTableViewCellPresenter.swift
//  SSAnalytics
//
//  Created by Peter Standret on 3/14/19.
//  Copyright © 2019 startupsoft. All rights reserved.
//

import Foundation
import STT

final class CellTableViewCellPresenter: SttPresenter<CellTableViewCellViewDelegate> {
    
    weak var parent: CellTableViewCellDelegate!
    
    let avatarImage: Dynamic<Image>
    let name: Dynamic<String>
    let job: Dynamic<String>
    let phone: Dynamic<String>
    
    init(avatarImage: String?, name: String, job: String, phone: String) {
        
        self.avatarImage = Dynamic(Image(data: nil, url: avatarImage))
        self.name = Dynamic(name)
        self.job = Dynamic(job)
        self.phone = Dynamic(phone)
        
        super.init(notificationError: nil)
    }
}
