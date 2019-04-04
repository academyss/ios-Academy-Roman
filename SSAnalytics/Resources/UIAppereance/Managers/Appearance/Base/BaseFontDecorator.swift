//
//  BaseFontDecorator.swift
//  STT
//
//  Created by Piter Standret on 1/12/19.
//  Copyright © 2019 Piter Standret. All rights reserved.
//

import Foundation
import UIKit

class BaseFontDecorator: FontAppearanceDecoratorType {
    
    private var fontSize: FontRelativeSize
    
    init (fontSize: FontRelativeSize) {
        self.fontSize = fontSize
    }
    
    var buttonSizeFont: CGFloat { return CGFloat(fontSize.k * 14) }
}
