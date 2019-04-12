//
//  ApiDataProvider.swift
//  SSAnalytics
//
//  Created by Peter Standret on 3/14/19.
//  Copyright © 2019 startupsoft. All rights reserved.
//

import Foundation
import RxSwift
import STT

final class ApiDataProvider: ApiDataProviderType {
    
    
    
    private var _httpService: SttHttpServiceType!
    
    init (httpService: SttHttpServiceType) {
        _httpService = httpService
    }
    
    // MARK: - ACCOUNT
    
    
    func signIn(data: SignInApiModel) -> Observable<TokenApiModel> {
        return _httpService.post(controller: ApiConroller.token,
                                 data: ["grant_type": "password",
                                          "username": data.email,
                                          "password": data.password], insertToken: false)
            .getResult()
    }
    
    func getUsersByInput(input: String) -> Observable<[UserApiModel]> {
        return _httpService.get(controller: ApiConroller.users("GetUsersByInput"), data: ["input": input], insertToken: true)
            .getResult()
    }
    
    func getUsersById(userId: String) -> Observable<UserApiModel> {
        return _httpService.get(controller: ApiConroller.users("GetUsersById"), data: ["UserId": userId], insertToken: true)
            .getResult()
    }
    
}
