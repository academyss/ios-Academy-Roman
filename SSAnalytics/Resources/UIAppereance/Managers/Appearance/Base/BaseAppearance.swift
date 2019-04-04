//
//  BaseAppearance.swift
//  STT
//
//  Created by Piter Standret on 1/1/19.
//  Copyright © 2019 Piter Standret. All rights reserved.
//

import Foundation

class BaseAppearance {
    
    let _colorDecorator: ColorAppearanceDecoratorType
    let _fontDecorator: FontAppearanceDecoratorType
    
    required init (colorDecorator: ColorAppearanceDecoratorType, fontDecorator: FontAppearanceDecoratorType) {
        _colorDecorator = colorDecorator
        _fontDecorator = fontDecorator
    }
}
