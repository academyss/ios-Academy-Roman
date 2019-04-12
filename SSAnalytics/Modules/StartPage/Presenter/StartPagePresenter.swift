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
    
    private(set) lazy var loginCommand = SttCommand(delegate: self, handler: { $0.onLogin() })
    private(set) lazy var changeLogoCommand = SttCommand(delegate: self, handler: { $0.onLogo() })
    
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
    
    func onLogin() {
        if canSignUp {
            _interactor.getToken(data: SignInApiModel(email: email.rawValue.value!, password: password.rawValue.value!))
                .subscribe(onNext: { (token) in
                    print(token)
                }, onCompleted: {
                    self._router.navigateWithSegue(to: EmployeeListPresenter.self, parametr: nil)
                }).disposed(by: disposeBag)
        }
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
    }
        
}
