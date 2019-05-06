//
//  ProfileInfoModuleAssembler.swift
//  SSAnalytics
//
//  Created by StartupSoft Mac6 on 4/22/19.
//  Copyright © 2019 startupsoft. All rights reserved.
//

import Swinject
import SwinjectStoryboard
import STT

final class ProfileInfoModuleAssembler: Assembly {
    
    //Module assembly
    func assemble(container: Container) {
        container.register(ProfileInfoRouterType.self) { (r, vc: ProfileInfoViewController) in ProfileInfoRouter(transitionHandler: vc) }
        
        container.register(ProfileInfoInteractorType.self,
                           factory: { (r) in ProfileInfoInteractor() })
        
        container.register(ProfileInfoPresenter.self) { (r, vc: ProfileInfoViewController) in
            ProfileInfoPresenter(view: vc, notificationService: r.resolve(SttNotificationErrorServiceType.self)!,
                                 router: r.resolve(ProfileInfoRouterType.self, argument: vc)!, interactor: r.resolve(ProfileInfoInteractorType.self)!)
        }
        container.storyboardInitCompleted(ProfileInfoViewController.self) { r, viewController in
            viewController.presenter = r.resolve(ProfileInfoPresenter.self, argument: viewController)!
        }
    }
}
