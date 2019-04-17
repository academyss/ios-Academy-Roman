//
//  StartPageInteractorType.swift
//  SSAnalytics
//
//  Created by Peter Standret on 3/14/19.
//  Copyright © 2019 startupsoft. All rights reserved.
//

import Foundation
import RxSwift

protocol StartPageInteractorType {
    func getToken(email: String, password: String) -> Observable<TokenApiModel>
    func logOut()
}
