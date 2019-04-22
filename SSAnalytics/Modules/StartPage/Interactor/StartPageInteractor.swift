//
//  StartPageInteractor.swift
//  SSAnalytics
//
//  Created by Peter Standret on 3/14/19.
//  Copyright © 2019 startupsoft. All rights reserved.
//

import Foundation
import RxSwift
import STT

final class StartPageInteractor: StartPageInteractorType {
    
    private let _accountsRepository: AccountRepositoryType
    private let _notificationErrorService: SttNotificationErrorServiceType
    
    init(accountsRepository: AccountRepositoryType, notificationErrorService: SttNotificationErrorServiceType) {
        _accountsRepository = accountsRepository
        _notificationErrorService = notificationErrorService
    }
    
    func getToken(email: String, password: String) -> Observable<TokenApiModel> {
        return _accountsRepository.getToken(data: SignInApiModel(email: email, password: password))
            .useError(service: _notificationErrorService, ignoreBadRequest: false, customMessage: "Error")
    }
    
    func logOut() {
        _accountsRepository.logOut()
    }
}
