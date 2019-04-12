//
//  UsersRepository.swift
//  SSAnalytics
//
//  Created by StartupSoft Mac6 on 4/11/19.
//  Copyright © 2019 startupsoft. All rights reserved.
//

import Foundation
import RxSwift


final class UsersRepository: BaseRepository, UsersRepositoryType {
    
    func getUsersByInput(input: String) -> Observable<[UserApiModel]> {
        return _apiDataProvider.getUsersByInput(input: input)
    }
    
    
}
