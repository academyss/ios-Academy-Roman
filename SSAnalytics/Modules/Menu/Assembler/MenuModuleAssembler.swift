//
//  MenuModuleAssembler.swift
//  SSAnalytics
//
//  Created by StartupSoft Mac6 on 4/15/19.
//  Copyright © 2019 startupsoft. All rights reserved.
//

import Swinject
import SwinjectStoryboard
import STT

final class MenuModuleAssembler: Assembly {
    
    //Module assembly
    func assemble(container: Container) {
        container.register(MenuRouterType.self) { (r, vc: MenuViewController) in MenuRouter(transitionHandler: vc) }
        
        container.register(MenuInteractorType.self,
                           factory: { (r) in MenuInteractor(usersRepository: r.resolve(UsersRepositoryType.self)!,
                                                            notificationErrorService: r.resolve(SttNotificationErrorServiceType.self)!) })
        
        container.register(MenuPresenter.self) { (r, vc: MenuViewController) in
            MenuPresenter(view: vc, notificationService: r.resolve(SttNotificationErrorServiceType.self)!,
                          router: r.resolve(MenuRouterType.self, argument: vc)!, interactor: r.resolve(MenuInteractorType.self)!)
        }
        container.storyboardInitCompleted(MenuViewController.self) { r, viewController in
            viewController.presenter = r.resolve(MenuPresenter.self, argument: viewController)!
        }
    }
}
