//
//  MenuInteractorType.swift
//  SSAnalytics
//
//  Created by StartupSoft Mac6 on 4/15/19.
//  Copyright © 2019 startupsoft. All rights reserved.
//

import Foundation
import RxSwift

protocol MenuInteractorType {
    func getCurrentUserInfo() -> Observable<UserApiModel>
}
