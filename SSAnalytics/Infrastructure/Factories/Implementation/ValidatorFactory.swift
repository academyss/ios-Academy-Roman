//
//  ValidatorFactory.swift
//  SSAnalytics
//
//  Created by StartupSoft Mac6 on 4/10/19.
//  Copyright © 2019 startupsoft. All rights reserved.
//

import Foundation
import STT

class ValidatorFactory: ValidatorFactoryType {
    
    func createEmailValidator() -> ValidatorFieldData {
        let validator = SttValidatorBuilder<SttValidator>(name: "Email")
            .useMin(5)
            .useMax(100)
            .usePattern("[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}")
            .useUnique(true)
            .build()
        
        return ValidatorFieldData(rawValidator: validator)
    }
    
    func createPasswordValidator() -> ValidatorFieldData {
        let validator = SttValidatorBuilder<SttValidator>(name: "Password")
            .useMin(5)
            .useMax(100)
            .build()
        
        return ValidatorFieldData(rawValidator: validator)
    }
    
    
}
