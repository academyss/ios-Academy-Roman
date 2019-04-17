//
//  MenuInteractor.swift
//  SSAnalytics
//
//  Created by StartupSoft Mac6 on 4/15/19.
//  Copyright © 2019 startupsoft. All rights reserved.
//

import Foundation
import RxSwift
import STT

final class MenuInteractor: MenuInteractorType {
    
    private let _usersRepository: UsersRepositoryType
    private let _notificationErrorService: SttNotificationErrorServiceType
    
    init(usersRepository: UsersRepositoryType, notificationErrorService: SttNotificationErrorServiceType) {
        _usersRepository = usersRepository
        _notificationErrorService = notificationErrorService
    }
    
    func getCurrentUserInfo() -> Observable<UserApiModel> {
        return _usersRepository.getUsersById(userId: nil)
            .useError(service: _notificationErrorService)
    }
    
    
}
