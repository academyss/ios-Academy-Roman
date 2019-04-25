//
//  WorkLogModuleAssembler.swift
//  SSAnalytics
//
//  Created by StartupSoft Mac6 on 4/22/19.
//  Copyright © 2019 startupsoft. All rights reserved.
//

import Swinject
import SwinjectStoryboard
import STT

final class WorkLogModuleAssembler: Assembly {
    
	//Module assembly
    func assemble(container: Container) {
        container.register(WorkLogRouterType.self) { (r, vc: WorkLogViewController) in WorkLogRouter(transitionHandler: vc) }
        
		container.register(WorkLogInteractorType.self,
                           factory: { (r) in WorkLogInteractor() })

        container.register(WorkLogPresenter.self) { (r, vc: WorkLogViewController) in
            WorkLogPresenter(view: vc, notificationService: r.resolve(SttNotificationErrorServiceType.self)!,
                                   router: r.resolve(WorkLogRouterType.self, argument: vc)!, interactor: r.resolve(WorkLogInteractorType.self)!)
        }
        container.storyboardInitCompleted(WorkLogViewController.self) { r, viewController in
            viewController.presenter = r.resolve(WorkLogPresenter.self, argument: viewController)!
        }
    }
}
