//
//  StartPageViewController.swift
//  SSAnalytics
//
//  Created by Peter Standret on 3/14/19.
//  Copyright © 2019 startupsoft. All rights reserved.
//

import Foundation
import UIKit
import STT

class StartPageViewController: SttKeyboardViewController<StartPagePresenter>, StartPageViewDelegate {

    @IBOutlet weak var loginInputBox: SttInputBox!
    @IBOutlet weak var passwordInputBox: SttInputBox!
    @IBOutlet weak var loginButton: SttButton!
    @IBOutlet weak var logoImageView: UIImageView!
    
    private var emailHandlerValidator: SttTextFieldHandlerValidator!
    private var passwordHandlerValidator: SttTextFieldHandlerValidator!
    
    override func viewDidLoad() {
        self.useErrorLabel = false
        super.hideNavigationBar = true
        super.viewDidLoad()
        setupInputBoxes()
        setupLoginButton()
    }

    override func keyboardWillHide(height: CGFloat) {
        super.keyboardWillHide(height: height)
        self.loginInputBox.endEditing()
        self.passwordInputBox.endEditing()
        changeLogo()
    }
    
    var set: SttBindingSet<StartPageViewController>!
    
    override func bind() {
        super.bind()
        set = SttBindingSet(parent: self)
        
        set.bind(loginButton).to(presenter.loginCommand)
        
        set.bind(loginInputBox.textField).forTarget(.didStartEditing)
            .to(presenter.changeLogoCommand)
        set.bind(loginInputBox.textField).to(presenter.email.rawValue)
        set.bind(loginInputBox.textField).forTarget(.didEndEditing)
            .to(presenter.validate).withCommandParametr(ValidationFieldType.email)
        set.bind(String.self).forProperty({ $0.loginInputBox.error = $1 })
            .to(presenter.email.errorValue)
        
        set.bind(passwordInputBox.textField).forTarget(.didStartEditing)
            .to(presenter.changeLogoCommand)
        set.bind(passwordInputBox.textField).to(presenter.password.rawValue)
        set.bind(passwordInputBox.textField).forTarget(.didEndEditing)
            .to(presenter.validate).withCommandParametr(ValidationFieldType.password)
        set.bind(String.self).forProperty({ $0.passwordInputBox.error = $1 })
            .to(presenter.password.errorValue)
        
        emailHandlerValidator = SttTextFieldHandlerValidator(delegate: self, inputBox: loginInputBox, handler: loginInputBox.textFieldHandler,
                                                             action: { $0.presenter.validate.execute(parametr: .email) })
        passwordHandlerValidator = SttTextFieldHandlerValidator(delegate: self, inputBox: passwordInputBox, handler: passwordInputBox.textFieldHandler,
                                                                action: { $0.presenter.validate.execute(parametr: .password) })
        
        loginInputBox.textFieldHandler.addTarget(type: .shouldReturn, delegate: self) { (v,_) in v.passwordInputBox.becomeFirstResponder() }
        passwordInputBox.textFieldHandler.addTarget(type: .shouldReturn, delegate: self) { (v, _) in v.view.endEditing(true) }
        
        set.apply()
        presenter.loginCommand.useIndicator(view: loginButton).disposed(by: presenter.listenerDisposableBag)
        presenter.loginCommand.useWork(start: { self.loginButton.setTitle("", for: .normal) }, end: { self.loginButton.setTitle("Login", for: .normal) })
            .disposed(by: presenter.listenerDisposableBag)
        
    }
    
    func changeLogo() {
        if self.loginInputBox.isEdited || self.passwordInputBox.isEdited {
            UIView.animate(withDuration: 2, animations: {
                self.logoImageView.image = UIImage(named: "StartupSoftFullLogo")
            }, completion: nil)
        } else {
            UIView.animate(withDuration: 2, animations: {
                self.logoImageView.image = UIImage(named: "StartupSoftShortLogo")
            })
        }
    }
    
}
