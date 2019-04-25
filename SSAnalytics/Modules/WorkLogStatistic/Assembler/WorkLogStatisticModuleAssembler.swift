//
//  WorkLogStatisticModuleAssembler.swift
//  SSAnalytics
//
//  Created by StartupSoft Mac6 on 4/22/19.
//  Copyright © 2019 startupsoft. All rights reserved.
//

import Swinject
import SwinjectStoryboard
import STT

final class WorkLogStatisticModuleAssembler: Assembly {
    
	//Module assembly
    func assemble(container: Container) {
        container.register(WorkLogStatisticRouterType.self) { (r, vc: WorkLogStatisticViewController) in WorkLogStatisticRouter(transitionHandler: vc) }
        
		container.register(WorkLogStatisticInteractorType.self,
                           factory: { (r) in WorkLogStatisticInteractor(workLogRepository: r.resolve(WorkLogRepositoryType.self)!,
                                                                        notificationErrorService: r.resolve(SttNotificationErrorServiceType.self)!) })

        container.register(WorkLogStatisticPresenter.self) { (r, vc: WorkLogStatisticViewController) in
            WorkLogStatisticPresenter(view: vc, notificationService: r.resolve(SttNotificationErrorServiceType.self)!,
                                   router: r.resolve(WorkLogStatisticRouterType.self, argument: vc)!, interactor: r.resolve(WorkLogStatisticInteractorType.self)!)
        }
        container.storyboardInitCompleted(WorkLogStatisticViewController.self) { r, viewController in
            viewController.presenter = r.resolve(WorkLogStatisticPresenter.self, argument: viewController)!
        }
    }
}
