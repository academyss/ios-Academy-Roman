//
//  AppDelegate.swift
//  SSAnalytics
//
//  Created by Peter Standret on 3/14/19.
//  Copyright © 2019 startupsoft. All rights reserved.
//

import UIKit
import STT

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        self.useAppCenter()
        self.clearKeychainIfWillUnistall()
        self.configureNetworkDebugger()
        self.configureCacheOptions()
        self.configureStartOption()
        
        return true
    }
    
    public func applicationDidEnterBackground(_ application: UIApplication) {
        SttGlobalObserver.applicationStatusChanged(status: .didEnterBackgound)
    }
    
    public func applicationWillEnterForeground(_ application: UIApplication) {
        SttGlobalObserver.applicationStatusChanged(status: .willEnterForeground)
    }
}

