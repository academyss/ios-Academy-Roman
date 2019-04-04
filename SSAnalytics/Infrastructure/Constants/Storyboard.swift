//
//  Storyboard.swift
//  SSAnalytics
//
//  Created by Peter Standret on 3/14/19.
//  Copyright © 2019 startupsoft. All rights reserved.
//

import Foundation
import STT

enum Storyboard: String, SttStoryboardType {
    
    case start = "Start"
    case application = "Application"
    
    var name: String { return self.rawValue }
}
