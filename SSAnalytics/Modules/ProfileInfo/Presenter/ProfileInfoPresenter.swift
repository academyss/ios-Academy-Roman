//
//  ProfileInfoPresenter.swift
//  SSAnalytics
//
//  Created by StartupSoft Mac6 on 4/22/19.
//  Copyright © 2019 startupsoft. All rights reserved.
//

import Foundation
import STT

final class ProfileInfoPresenter: SttPresenterWithParametr<ProfileInfoViewDelegate, EmployeeApiModel> {
    

    private let _router: ProfileInfoRouterType
    private let _interactor: ProfileInfoInteractorType
    
    var avatar: Dynamic<Image>!
    var name: Dynamic<String>!
    var roles: Dynamic<String?>!
    var email: Dynamic<String>!
    var phone: Dynamic<String>!
    var skype: Dynamic<String?>!
    
    init(view: SttViewable, notificationService: SttNotificationErrorServiceType, router: ProfileInfoRouterType,
         interactor: ProfileInfoInteractorType) {
        
        _router = router
		_interactor = interactor
        
        super.init(notificationError: notificationService)
        super.injectView(delegate: view)
    }
    
    override func prepare(parametr: Any?) {
        
        if let userModel: EmployeeApiModel = parametr as? EmployeeApiModel {
            self.avatar = Dynamic(Image(data: nil, url: userModel.imageUrl))
            self.name = Dynamic(userModel.name)
            self.roles = Dynamic(userModel.roles.joined(separator: ", "))
            self.email = Dynamic(userModel.email)
            self.phone = Dynamic(userModel.phoneNumber)
            self.skype = userModel.skype != nil ? Dynamic(userModel.skype) : Dynamic("No skype")
        }
        
    }
}
