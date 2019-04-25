//
//  WorkLogLogTimeModuleAssembler.swift
//  SSAnalytics
//
//  Created by StartupSoft Mac6 on 4/22/19.
//  Copyright © 2019 startupsoft. All rights reserved.
//

import Swinject
import SwinjectStoryboard
import STT

final class WorkLogLogTimeModuleAssembler: Assembly {
    
	//Module assembly
    func assemble(container: Container) {
        container.register(WorkLogLogTimeRouterType.self) { (r, vc: WorkLogLogTimeViewController) in WorkLogLogTimeRouter(transitionHandler: vc) }
        
		container.register(WorkLogLogTimeInteractorType.self,
                           factory: { (r) in WorkLogLogTimeInteractor(workLogRepository: r.resolve(WorkLogRepositoryType.self)!,
                                                                      notificationErrorService: r.resolve(SttNotificationErrorServiceType.self)!) })

        container.register(WorkLogLogTimePresenter.self) { (r, vc: WorkLogLogTimeViewController) in
            WorkLogLogTimePresenter(view: vc, notificationService: r.resolve(SttNotificationErrorServiceType.self)!,
                                   router: r.resolve(WorkLogLogTimeRouterType.self, argument: vc)!, interactor: r.resolve(WorkLogLogTimeInteractorType.self)!)
        }
        container.storyboardInitCompleted(WorkLogLogTimeViewController.self) { r, viewController in
            viewController.presenter = r.resolve(WorkLogLogTimePresenter.self, argument: viewController)!
        }
    }
}
