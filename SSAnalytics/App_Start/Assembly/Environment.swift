//
//  Environment.swift
//  SSAnalytics
//
//  Created by Peter Standret on 3/14/19.
//  Copyright © 2019 startupsoft. All rights reserved.
//

import Foundation

struct Environment {
    
    fileprivate static var infoDict: [String: Any]  {
        get {
            if let dict = Bundle.main.infoDictionary {
                return dict
            }
            else {
                fatalError("Plist file not found")
            }
        }
    }
    
    static func configuration(_ key: PlistKey) -> String {
        return infoDict[key.rawValue] as! String
    }
}
