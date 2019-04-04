//
//  LightAppearanceFactory.swift
//  STT
//
//  Created by Piter Standret on 1/1/19.
//  Copyright © 2019 Piter Standret. All rights reserved.
//

import Foundation

class LightAppearanceFactory: AppearanceFactoryType {
    
    private let fontSize: FontRelativeSize
    
    init (fontSize: FontRelativeSize) {
        self.fontSize = fontSize
    }
    
    var colorDecorator: ColorAppearanceDecoratorType = LightColorAppearanceDecorator()
    lazy var fontDecorator: FontAppearanceDecoratorType = LightFontAppearanceDecorator(fontSize: fontSize)
    
    lazy var viewAppearance: ViewAppearanceType = LightViewAppearance(colorDecorator: colorDecorator,
                                                                      fontDecorator: fontDecorator)
    lazy var navigationBarAppearance: NavigationBarAppearanceType = LightNavigationBarAppearance(colorDecorator: colorDecorator,
                                                                                                 fontDecorator: fontDecorator)
    lazy var componentsAppearance: ComponentsAppearanceType = LightComponentsAppearance(colorDecorator: colorDecorator,
                                                                                        fontDecorator: fontDecorator)
    lazy var textFieldAppearance: TextFieldAppearanceType = LightTextFieldAppearance(colorDecorator: colorDecorator,
                                                                                     fontDecorator: fontDecorator)
    lazy var textViewAppearance: TextViewAppearanceType = LightTextViewAppearance(colorDecorator: colorDecorator,
                                                                                 fontDecorator: fontDecorator)
    lazy var labelAppearance: LabelAppearanceType = LightLabelAppearance(colorDecorator: colorDecorator,
                                                                         fontDecorator: fontDecorator)
    lazy var buttonAppearance: ButtonAppearanceType = LightButtonAppearance(colorDecorator: colorDecorator,
                                                                            fontDecorator: fontDecorator)
    lazy var tableViewAppearance: TableViewAppearanceType = LightTableViewAppearance(colorDecorator: colorDecorator,
                                                                                         fontDecorator: fontDecorator)
    lazy var searchBarAppearance: SearchBarAppearanceType = LightSearchBarAppearance(colorDecorator: colorDecorator,
                                                                                         fontDecorator: fontDecorator)
    lazy var sliderAppearance: SliderAppearanceType = LightSliderAppearance(colorDecorator: colorDecorator,
                                                                            fontDecorator: fontDecorator)
    
    
    lazy var appearanceTypes: [AppearanceType] = [
        viewAppearance,
        navigationBarAppearance,
        componentsAppearance,
        textFieldAppearance,
        textFieldAppearance,
        textViewAppearance,
        labelAppearance,
        buttonAppearance,
        tableViewAppearance,
        searchBarAppearance,
        sliderAppearance
    ]
}
