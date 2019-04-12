//
//  ApiDataProviderType.swift
//  SSAnalytics
//
//  Created by Peter Standret on 3/14/19.
//  Copyright © 2019 startupsoft. All rights reserved.
//

import Foundation
import RxSwift

protocol ApiDataProviderType {
    
    // MARK: - ACCOUNT
    
    func signIn(data: SignInApiModel) -> Observable<TokenApiModel>
    func getUsersByInput(input: String) -> Observable<[UserApiModel]>
    func getUsersById(userId: String) -> Observable<UserApiModel>
    
}
