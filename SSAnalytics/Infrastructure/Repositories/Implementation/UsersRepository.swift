//
//  UsersRepository.swift
//  SSAnalytics
//
//  Created by StartupSoft Mac6 on 4/11/19.
//  Copyright © 2019 startupsoft. All rights reserved.
//

import Foundation
import RxSwift
import STT

final class UsersRepository: BaseRepository, UsersRepositoryType {
    
    func getUsersByInput(input: String) -> Observable<[EmployeeApiModel]> {
        return _apiDataProvider.getUsersByInput(input: input)
    }
    
    func getUsersById(userId: String?) -> Observable<UserApiModel> {
        if let id = userId {
            return _apiDataProvider.getUsersById(userId: id)
        }
        if _keyValueStorageProvider.token.isExists() {
            return _apiDataProvider.getUsersById(userId: _keyValueStorageProvider.token.get().userId)
        } else {
            return Observable.error(SttBaseError.unkown("Token not exist"))
        }
    }
    
}
