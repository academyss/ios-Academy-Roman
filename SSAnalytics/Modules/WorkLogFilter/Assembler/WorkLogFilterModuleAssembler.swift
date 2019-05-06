//
//  WorkLogFilterModuleAssembler.swift
//  SSAnalytics
//
//  Created by StartupSoft Mac6 on 4/30/19.
//  Copyright © 2019 startupsoft. All rights reserved.
//

import Swinject
import SwinjectStoryboard
import STT

final class WorkLogFilterModuleAssembler: Assembly {
    
	//Module assembly
    func assemble(container: Container) {
        container.register(WorkLogFilterRouterType.self) { (r, vc: WorkLogFilterViewController) in WorkLogFilterRouter(transitionHandler: vc) }
        
		container.register(WorkLogFilterInteractorType.self,
                           factory: { (r) in WorkLogFilterInteractor() })

        container.register(WorkLogFilterPresenter.self) { (r, vc: WorkLogFilterViewController) in
            WorkLogFilterPresenter(view: vc, notificationService: r.resolve(SttNotificationErrorServiceType.self)!,
                                   router: r.resolve(WorkLogFilterRouterType.self, argument: vc)!, interactor: r.resolve(WorkLogFilterInteractorType.self)!)
        }
        container.storyboardInitCompleted(WorkLogFilterViewController.self) { r, viewController in
            viewController.presenter = r.resolve(WorkLogFilterPresenter.self, argument: viewController)!
        }
    }
}
