//
//  UIAppereanceManager.swift
//  STT
//
//  Created by Piter Standret on 12/23/18.
//  Copyright © 2018 Piter Standret. All rights reserved.
//

import Foundation
import Swinject
import STT

enum ThemeType {
    case night
    case light
}

final class AppearanceManager {
    
    private static var _fontSize: FontRelativeSize!
    private static var _themeType: ThemeType!
    private static var _factory: AppearanceFactoryType!
    
    static var fontSize: FontRelativeSize { return _fontSize }
    static var themeType: ThemeType { return _themeType }
    static var appearanceFactory: AppearanceFactoryType { return _factory }
    
    static func load(themeType: ThemeType, fontSize: FontRelativeSize? = nil) {
        
        self._themeType = themeType
        self._fontSize = fontSize ?? _fontSize
        
        switch themeType {
        case .light: registerLightTheme(container: ApplicationAssembly.instance.assembler.resolver as! Container)
        case .night: registerNightTheme(container: ApplicationAssembly.instance.assembler.resolver as! Container)
        }
        
        _factory = ApplicationAssembly.instance.assembler.resolver.resolve(AppearanceFactoryType.self)!
        reload(from: _factory.appearanceTypes)
        
        UIApplication.shared.reloadViewControllers()
    }
    
    static func reloadFont(with size: FontRelativeSize) {
        self.load(themeType: themeType, fontSize: size)
    }
    
    private static func reload(from object: [AppearanceType]) {
        for type in object {
            type.load()
        }
    }
    
    // MARK: - NIGHT
    
    private static func registerNightTheme(container: Container) {
        notImplementException()
    }
    
    
    // MARK: - LIGHT
    
    private static func registerLightTheme(container: Container) {
        container.register(AppearanceFactoryType.self, factory: { _ in LightAppearanceFactory(fontSize: fontSize) })
            .inObjectScope(.container)
    }
}
