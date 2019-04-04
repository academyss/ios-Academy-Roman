//
//  AppDelegateExtensions.swift
//  SSAnalytics
//
//  Created by Peter Standret on 3/14/19.
//  Copyright © 2019 startupsoft. All rights reserved.
//

import Foundation
import KeychainSwift
import SDWebImage
import AppCenter
import AppCenterAnalytics
import AppCenterCrashes
import AlamofireNetworkActivityLogger
import STT

extension AppDelegate {
    
    func configureStartOption()  {
        KeychainSwift().synchronizable = false
        var storyboardName = Storyboard.start.rawValue
        if KeychainSwift().get(Constants.tokenKey) != nil {
            storyboardName = Storyboard.application.rawValue
        }
        
        let stroyboard = UIStoryboard(name: storyboardName, bundle: nil)
        let viewContrl = stroyboard.instantiateViewController(withIdentifier: "start")
        
        self.window?.rootViewController = viewContrl
        self.window?.makeKeyAndVisible()
    }
    
    func clearKeychainIfWillUnistall() {
        let freshInstall = !UserDefaults.standard.bool(forKey: "alreadyInstalled")
        if freshInstall {
            KeychainSwift().clear()
            UserDefaults.standard.set(true, forKey: "alreadyInstalled")
        }
    }
    
    func configureCacheOptions() {
        SDWebImageManager.shared().imageCache?.config.maxCacheAge = Constants.maxCacheAge
        SDWebImageManager.shared().imageCache?.config.maxCacheSize = UInt(Constants.maxImageCacheSize)
        
        let size = Double((SDWebImageManager.shared().imageCache?.getSize())!)
        print("image cache size: \(size / 1024.0 / 1024.0)mb\nused: \(size * 100.0 / Double(Constants.maxImageCacheSize))/100%")
    }
    
    func useAppCenter() {
        MSAppCenter.start("2e153238-3506-4e84-851d-0c9822c8b2b3", withServices:[
            MSAnalytics.self,
            MSCrashes.self
            ])
    }
    
    func configureNetworkDebugger() {
        #if DEBUG
        NetworkActivityLogger.shared.level = .debug
        NetworkActivityLogger.shared.startLogging()
        #endif
    }
}
