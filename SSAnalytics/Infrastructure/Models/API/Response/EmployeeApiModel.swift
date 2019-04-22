//
//  UsersApiModel.swift
//  SSAnalytics
//
//  Created by StartupSoft Mac6 on 4/11/19.
//  Copyright © 2019 startupsoft. All rights reserved.
//

import Foundation


struct EmployeeApiModel: Decodable {
    
    var id: String
    var imageUrl: String
    var firstName: String
    var lastName: String
    var phoneNumber: String
    var email: String
    var skype: String?
    var roles: [String]

    var name: String {
        get {
            return firstName + " " + lastName
        }
    }
    
    enum CodingKeys: String, CodingKey {
        case id
        case imageUrl = "avatarUrl"
        case firstName
        case lastName
        case email
        case roles
        case phoneNumber
        case skype
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        self.id = try container.decode(String.self, forKey: .id)
        self.imageUrl = "https://prodssanalytics.blob.core.windows.net"
        self.imageUrl += try container.decode(String.self, forKey: .imageUrl)
        self.firstName = try container.decode(String.self, forKey: .firstName)
        self.lastName = try container.decode(String.self, forKey: .lastName)
        self.phoneNumber = try container.decode(String.self, forKey: .phoneNumber)
        self.skype = try container.decode(String?.self, forKey: .skype)
        self.roles = try container.decode([String].self, forKey: .roles)
        self.email = try container.decode(String.self, forKey: .email)
    }
    
    
}
