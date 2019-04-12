//
//  UsersApiModel.swift
//  SSAnalytics
//
//  Created by StartupSoft Mac6 on 4/11/19.
//  Copyright © 2019 startupsoft. All rights reserved.
//

import Foundation


struct UsersApiModel: Decodable {
    
    var imageUrl: String
    var firstName: String
    var lastName: String
    
    var name: String {
        get {
            return firstName + " " + lastName
        }
    }
    var roles: [String]
    
    enum CodingKeys: String, CodingKey {
        case imageUrl = "avatarUrl"
        case firstName
        case lastName
        case roles
    }
     
    
}
