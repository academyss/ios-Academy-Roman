//
//  GetUsersByInputMaper.swift
//  SSAnalytics
//
//  Created by StartupSoft Mac6 on 4/11/19.
//  Copyright © 2019 startupsoft. All rights reserved.
//

import Foundation
import STT

extension EmployeeApiModel {
    
    func convertToViewModel() -> CellTableViewCellPresenter {
        return CellTableViewCellPresenter(avatarImage: self.imageUrl,
                                          name: self.name,
                                          job: self.roles.joined(separator: ", "),
                                          phone: self.phoneNumber)
    }
}

extension Array where Element == EmployeeApiModel {
    
    func convertToViewModel() -> [CellTableViewCellPresenter] {
        return self.map({ $0.convertToViewModel() })
    }
}
