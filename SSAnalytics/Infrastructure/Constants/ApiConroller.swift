//
//  ApiConroller.swift
//  SSAnalytics
//
//  Created by Peter Standret on 3/14/19.
//  Copyright © 2019 startupsoft. All rights reserved.
//

import Foundation
import STT

enum ApiConroller: ApiControllerType {
    
    case token
    case users(String)
    case workLog(String)
    
    var route: String {
        get {
            var result: String!
            
            switch self {
            case .token: result = "token"
            case .users(let method): result = "users/\(method)"
            case .workLog(let method): result = ""
            }
            
            return result
        }
    }
}


//[Post("/token")]
//
//[Get("/users/GetUsersByInput")]
//
//[Get("/users/GetUsersById")]
