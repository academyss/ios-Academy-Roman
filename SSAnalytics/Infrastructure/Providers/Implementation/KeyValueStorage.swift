//
//  KeyValueStorage.swift
//  SSAnalytics
//
//  Created by Peter Standret on 3/14/19.
//  Copyright © 2019 startupsoft. All rights reserved.
//

import Foundation
import STT

final class KeyValueStorage: KeyValueStorageType {
    
     lazy var token: SttStorage<TokenApiModel> = SttStorage<TokenApiModel>(type: .security, key: Constants.tokenKey)
}
