//
//  EmployeeListInteractor.swift
//  SSAnalytics
//
//  Created by StartupSoft Mac6 on 4/5/19.
//  Copyright © 2019 startupsoft. All rights reserved.
//

import Foundation
import RxSwift
import STT

final class EmployeeListInteractor: EmployeeListInteractorType {
    
    
    private let _usersRepository: UsersRepositoryType
    private let _notificationErrorService: SttNotificationErrorServiceType
    
    init(usersRepository: UsersRepositoryType, notificationErrorService: SttNotificationErrorServiceType) {
        _usersRepository = usersRepository
        _notificationErrorService = notificationErrorService
    }
    
    func getUsersByInput(input: String) -> Observable<[CellTableViewCellPresenter]> {
        return _usersRepository.getUsersByInput(input: input)
            .map({ $0.convertToViewModel() })
            .useError(service: _notificationErrorService)
    }
    
    func getUsersById(userId: String) -> Observable<UserApiModel> {
        return _usersRepository.getUsersById(userId: userId)
    }
    
}
