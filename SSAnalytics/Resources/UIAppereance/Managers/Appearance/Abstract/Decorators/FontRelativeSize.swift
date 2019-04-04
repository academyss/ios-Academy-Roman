//
//  FontRelativeSize.swift
//  STT
//
//  Created by Piter Standret on 1/16/19.
//  Copyright © 2019 startupsoft. All rights reserved.
//

import Foundation

enum FontRelativeSize: Int {
    case tiny = 1, small
    case medium
    case big, large
    
    var k: Float {
        switch self {
        case .tiny: return 0.6
        case .small: return 0.8
        case .medium: return 1.0
        case .big: return 1.2
        case .large: return 1.4
        }
    }
}
