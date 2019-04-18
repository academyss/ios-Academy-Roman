//
//  StartPageViewControllerExtension.swift
//  SSAnalytics
//
//  Created by StartupSoft Mac6 on 4/18/19.
//  Copyright © 2019 startupsoft. All rights reserved.
//

import Foundation
import UIKit

extension StartPageViewController {
    
    func setupInputBoxes() {
        
        loginInputBox.labelDisableColor = UIColor(named: "LightGray")!
        loginInputBox.underlineDisableColor = UIColor(named: "LightGray")!
        loginInputBox.underlineActiveColor = UIColor(named: "Blue")!
        loginInputBox.underlineActiveHeight = CGFloat(1)
        loginInputBox.underlineDisableHeight = CGFloat(1)
        loginInputBox.textField.keyboardType = .emailAddress
        loginInputBox.label.text = "Login"
        loginInputBox.tintColor = UIColor.black
        loginInputBox.labelFont = UIFont.init(name: "Roboto", size: 36)
        loginInputBox.textField.font = UIFont.init(name: "Roboto", size: 18)
        loginInputBox.labelActiveColor = UIColor(named: "Blue")!
        
        
        passwordInputBox.typeInputBox = .security(.none)
        passwordInputBox.label.text = "**********"
        passwordInputBox.isSimpleLabel = true
        passwordInputBox.textField.font = UIFont.init(name: "Roboto", size: 18)
        passwordInputBox.labelDisableColor = UIColor(named: "LightGray")!
        passwordInputBox.underlineDisableColor = UIColor(named: "LightGray")!
        passwordInputBox.underlineActiveColor = UIColor(named: "Blue")!
        passwordInputBox.underlineDisableHeight = CGFloat(1)
        passwordInputBox.tintColor = UIColor.black
        
        
    }
    
    
    func setupLoginButton() {
        
        loginButton.backgroundColor = UIColor(named: "Blue")
        loginButton.layer.cornerRadius = 28
        loginButton.tintColor = UIColor.white
        
    }
    
    
}
