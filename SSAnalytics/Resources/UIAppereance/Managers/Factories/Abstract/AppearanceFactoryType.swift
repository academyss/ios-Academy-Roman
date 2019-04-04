//
//  AppearanceFactoryType.swift
//  STT
//
//  Created by Piter Standret on 1/16/19.
//  Copyright © 2019 startupsoft. All rights reserved.
//

import Foundation

protocol AppearanceFactoryType {
    
    var colorDecorator: ColorAppearanceDecoratorType { get }
    var fontDecorator: FontAppearanceDecoratorType { get }
    
    var viewAppearance: ViewAppearanceType { get }
    var navigationBarAppearance: NavigationBarAppearanceType { get }
    var componentsAppearance: ComponentsAppearanceType { get }
    var textFieldAppearance: TextFieldAppearanceType { get }
    var textViewAppearance: TextViewAppearanceType { get }
    var labelAppearance: LabelAppearanceType { get }
    var buttonAppearance: ButtonAppearanceType { get }
    var tableViewAppearance: TableViewAppearanceType { get }
    var searchBarAppearance: SearchBarAppearanceType { get }
    var sliderAppearance: SliderAppearanceType { get }
    
    var appearanceTypes: [AppearanceType] { get }
    
}
