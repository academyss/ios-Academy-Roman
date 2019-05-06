//
//  StartPagePresenter.swift
//  SSAnalytics
//
//  Created by Peter Standret on 3/14/19.
//  Copyright © 2019 startupsoft. All rights reserved.
//

import Foundation
import STT
import RxSwift

final class StartPagePresenter: SttPresenter<StartPageViewDelegate> {
    
    private let _router: SttRouterType
    private let _interactor: StartPageInteractorType
    
    let email: ValidatorFieldData
    let password: ValidatorFieldData
    
    var canSignUp: Bool { return !email.rawValidator.isError && !password.rawValidator.isError }
    
    private(set) lazy var loginCommand = SttCommand(delegate: self, handler: { $0.onLogin() }, handlerCanExecute: { $0.canSignUp })
    private(set) lazy var changeLogoCommand = SttCommand(delegate: self, handler: { $0.onLogo() })
    private(set) lazy var logOut = SttCommand(delegate: self, handler: { $0.onLogOut() })
    private(set) lazy var validate = SttComandWithParametr(delegate: self, handler: { $0.onValidate($1) })
    
    let disposeBag = DisposeBag()
    
    init(view: SttViewable, notificationService: SttNotificationErrorServiceType, router: SttRouterType,
         interactor: StartPageInteractorType, validatorFactory: ValidatorFactoryType) {
        
        _router = router
        _interactor = interactor
        
        email = validatorFactory.createEmailValidator()
        password = validatorFactory.createPasswordValidator()
        
        super.init(notificationError: notificationService)
        super.injectView(delegate: view)
    }
    
    override func viewAppeared() {
        super.viewAppeared()
        self.logOut.execute()
    }      
    
    func onLogin() {
        
        _interactor.getToken(email: email.rawValue.value!, password: password.rawValue.value!)
            .useWork(loginCommand)
            .subscribe(onNext: { [unowned self] _ in
                self._router.navigateWithSegue(to: EmployeeListPresenter.self, parametr: nil)
            }).disposed(by: disposeBag)
    }
    
    func onLogo() {
        self.delegate?.changeLogo()
    }
    
    func onValidate(_ type: ValidationFieldType) {
        switch type {
        case .email:
            self.email.raiseError(email.rawValue.value)
        case .password:
            self.password.raiseError(password.rawValue.value)
        }        
        self.loginCommand.raiseCanExecute(parametr: nil)
    }
    
    func onLogOut() {
        _interactor.logOut()
    }
    
}


