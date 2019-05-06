//
//  ProjectsModuleAssembler.swift
//  SSAnalytics
//
//  Created by StartupSoft Mac6 on 4/30/19.
//  Copyright © 2019 startupsoft. All rights reserved.
//

import Swinject
import SwinjectStoryboard
import STT

final class ProjectsModuleAssembler: Assembly {
    
    //Module assembly
    func assemble(container: Container) {
        container.register(ProjectsRouterType.self) { (r, vc: ProjectsViewController) in ProjectsRouter(transitionHandler: vc) }
        
        container.register(ProjectsInteractorType.self,
                           factory: { (r) in ProjectsInteractor(workLogRepository: r.resolve(WorkLogRepositoryType.self)!,
                                                                notificationErrorService: r.resolve(SttNotificationErrorServiceType.self)!) })
        
        container.register(ProjectsPresenter.self) { (r, vc: ProjectsViewController) in
            ProjectsPresenter(view: vc, notificationService: r.resolve(SttNotificationErrorServiceType.self)!,
                              router: r.resolve(ProjectsRouterType.self, argument: vc)!, interactor: r.resolve(ProjectsInteractorType.self)!)
        }
        container.storyboardInitCompleted(ProjectsViewController.self) { r, viewController in
            viewController.presenter = r.resolve(ProjectsPresenter.self, argument: viewController)!
        }
    }
}
