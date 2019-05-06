//
//  AccountRepository.swift
//  SSAnalytics
//
//  Created by Peter Standret on 3/14/19.
//  Copyright © 2019 startupsoft. All rights reserved.
//

import Foundation
import RxSwift

final class AccountRepository: BaseRepository, AccountRepositoryType {
   
    func getToken(data: SignInApiModel) -> Observable<TokenApiModel> {
        return _apiDataProvider.getToken(data: data)
            .map({ self._keyValueStorageProvider.token.put(item: $0); return $0 })
    }
    
    func logOut() {
        self._keyValueStorageProvider.token.drop()
    }
   
    
}
