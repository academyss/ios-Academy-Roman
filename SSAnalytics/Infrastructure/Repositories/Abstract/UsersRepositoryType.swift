//
//  UsersRepositoryType.swift
//  SSAnalytics
//
//  Created by StartupSoft Mac6 on 4/11/19.
//  Copyright © 2019 startupsoft. All rights reserved.
//

import Foundation
import RxSwift

protocol UsersRepositoryType {
    func getUsersByInput(input: String) -> Observable<[EmployeeApiModel]>
    func getUsersById(userId: String?) -> Observable<UserApiModel>

}
