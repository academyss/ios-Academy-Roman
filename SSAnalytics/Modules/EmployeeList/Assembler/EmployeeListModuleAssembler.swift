//
//  EmployeeListModuleAssembler.swift
//  SSAnalytics
//
//  Created by StartupSoft Mac6 on 4/5/19.
//  Copyright © 2019 startupsoft. All rights reserved.
//

import Swinject
import SwinjectStoryboard
import STT

final class EmployeeListModuleAssembler: Assembly {
    
    //Module assembly
    func assemble(container: Container) {
        container.register(EmployeeListRouterType.self) { (r, vc: EmployeeListViewController) in EmployeeListRouter(transitionHandler: vc) }
        
        container.register(EmployeeListInteractorType.self,
                           factory: { (r) in EmployeeListInteractor(usersRepository: r.resolve(UsersRepositoryType.self)!,
                                                                    notificationErrorService: r.resolve(SttNotificationErrorServiceType.self)!) })
        
        container.register(EmployeeListPresenter.self) { (r, vc: EmployeeListViewController) in
            EmployeeListPresenter(view: vc, notificationService: r.resolve(SttNotificationErrorServiceType.self)!,
                                  router: r.resolve(EmployeeListRouterType.self, argument: vc)!, interactor: r.resolve(EmployeeListInteractorType.self)!)
        }
        container.storyboardInitCompleted(EmployeeListViewController.self) { r, viewController in
            viewController.presenter = r.resolve(EmployeeListPresenter.self, argument: viewController)!
        }
    }
}
