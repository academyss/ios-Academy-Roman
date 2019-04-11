//
//  ValidatorFactoryType.swift
//  SSAnalytics
//
//  Created by StartupSoft Mac6 on 4/10/19.
//  Copyright © 2019 startupsoft. All rights reserved.
//

import Foundation
import STT

protocol ValidatorFactoryType {
    func createEmailValidator() -> ValidatorFieldData
    func createPasswordValidator() -> ValidatorFieldData
}
