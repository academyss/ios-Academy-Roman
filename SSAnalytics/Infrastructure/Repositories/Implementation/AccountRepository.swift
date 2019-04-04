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
   
    func signIn(data: SignInApiModel) -> Observable<TokenApiModel> {
        return _apiDataProvider.signIn(data: data)
            .map({self._keyValueStorageProvider.token.put(item: $0); return $0 })
    }
}
