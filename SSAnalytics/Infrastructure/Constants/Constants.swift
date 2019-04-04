//
//  Constants.swift
//  SSAnalytics
//
//  Created by Peter Standret on 3/14/19.
//  Copyright © 2019 startupsoft. All rights reserved.
//

import Foundation

final class Constants {
    
    // keychain id
    static let tokenKey = "securityAccessToken"
    static let idKey = "securityUserId"
    static let idEmeail = "securityEmail"
    static let idPassword = "securityPassword"
    
    // api config
    static let maxImageCacheSize = 1024 * 1024 * 200
    static let maxCacheAge = 60 * 60 * 24 * 7 * 4
    static let timeout = TimeInterval(15) + TimeInterval(timeWaitNextRequest)
    static let timeWaitNextRequest = UInt32(2)
    static let maxCountRepeatRequest = 3
    static let tokenPrefix = "Bearer "
    
    // image key
    static let avatarPlaceholder = "avatarPlaceholder"
    
    // realm
    static let keySingle = "--single--"
    
    // log - key
    static let systemLog = "SystemLog"
    static let httpKeyLog = "HTTP"
    static let apiDataKeyLog = "APIDP"
    static let repositoryLog = "RealmRep"
    static let repositoryExtensionsLog = "RealmEXTRep"
    static let noImplementException = "No implement exception"
}
