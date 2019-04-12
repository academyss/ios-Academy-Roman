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
    
    func signIn(data: SignInApiModel) -> Observable<TokenApiModel> {
        return _accountsRepository.signIn(data: data)
            .useError(service: _notificationErrorService)
        
    }
}
