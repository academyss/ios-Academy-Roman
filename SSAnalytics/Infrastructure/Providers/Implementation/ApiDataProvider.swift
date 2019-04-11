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
//        return _httpService.post(controller: ApiConroller.auth(nil), object: data, insertToken: true)
//            .getResult()
        notImplementException()
    }
    
    
}
