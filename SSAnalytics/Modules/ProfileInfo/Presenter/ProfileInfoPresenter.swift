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
    
    let avatar = Dynamic<Image>(Image(data: nil, url: nil))
    let name = Dynamic<String>("")
    let roles = Dynamic<String?>("")
    let email = Dynamic<String>("")
    let phone = Dynamic<String>("")
    let skype = Dynamic<String?>("")
    
    private(set) lazy var call = SttCommand(delegate: self, handler: { $0.onCall() })
    private(set) lazy var sendEmail = SttCommand(delegate: self, handler: { $0.onEmail() })
    
    init(view: SttViewable, notificationService: SttNotificationErrorServiceType, router: ProfileInfoRouterType,
         interactor: ProfileInfoInteractorType) {
        
        _router = router
        _interactor = interactor
        
        super.init(notificationError: notificationService)
        super.injectView(delegate: view)
    }
    
    override func prepare(parametr: Any?) {
        
        if let userModel: EmployeeApiModel = parametr as? EmployeeApiModel {
            self.avatar.value = Image(data: nil, url: userModel.imageUrl)
            self.name.value = userModel.name
            self.roles.value = userModel.roles.joined(separator: ", ")
            self.email.value = userModel.email
            self.phone.value = userModel.phoneNumber
            self.skype.value = userModel.skype != nil ? userModel.skype : "No skype"
        }
    }
    
    func onCall() {
        guard let number = URL(string: "tel://" + phone.value) else { return }
        UIApplication.shared.open(number)
    }
    
    func onEmail() {
        let email = self.email.value
        if let url = URL(string: "mailto:\(email)") {
            if #available(iOS 10.0, *) {
                UIApplication.shared.open(url)
            } else {
                UIApplication.shared.openURL(url)
            }
        }
    }
}
