//
//  UsersApiModel.swift
//  SSAnalytics
//
//  Created by StartupSoft Mac6 on 4/11/19.
//  Copyright © 2019 startupsoft. All rights reserved.
//

import Foundation


struct UserApiModel: Decodable {
    
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
        case imageUrl = "croppedAvatarUrl"
        case firstName
        case lastName
        case roles
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        imageUrl = try values.decode(String.self, forKey: .imageUrl)
        if imageUrl == "" {
            imageUrl = "analytics.startupsoft.org/Content/img/userProfile/user.jpg"
        } else {
            imageUrl = "qassanalytics.blob.core.windows.net" + imageUrl
        }
        firstName = try values.decode(String.self, forKey: .firstName)
        lastName = try values.decode(String.self, forKey: .lastName)
        roles = try values.decode([String].self, forKey: .roles)
    }
    
}
