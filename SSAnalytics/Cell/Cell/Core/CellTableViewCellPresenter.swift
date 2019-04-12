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
    
    init(avatarImage: String?, name: String, job: String) {
        if avatarImage?.isEmpty ?? false {
            self.avatarImage = Dynamic(Image(data: nil, url: avatarImage))
        } else {
            self.avatarImage = Dynamic(Image(data: nil, url: "http://pluspng.com/img-png/user-png-icon-male-user-icon-512.png"))
        }
        self.name = Dynamic(name)
        self.job = Dynamic(job)
        
        super.init(notificationError: nil)
    }
}
