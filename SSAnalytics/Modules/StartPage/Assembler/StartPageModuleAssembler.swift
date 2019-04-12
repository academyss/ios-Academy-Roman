//
//  StartPageModuleAssembler.swift
//  SSAnalytics
//
//  Created by Peter Standret on 3/14/19.
//  Copyright © 2019 startupsoft. All rights reserved.
//

import Swinject
import SwinjectStoryboard
import STT

final class StartPageModuleAssembler: Assembly {
    
	//Module assembly
    func assemble(container: Container) {
        
		container.register(StartPageInteractorType.self,
                           factory: { (r) in StartPageInteractor(accountsRepository: r.resolve(AccountRepositoryType.self)!,
                                                                 notificationErrorService: r.resolve(SttNotificationErrorServiceType.self)!) })

        container.register(StartPagePresenter.self) { (r, vc: StartPageViewController) in
            StartPagePresenter(view: vc, notificationService: r.resolve(SttNotificationErrorServiceType.self)!,
                          router: SttRouter(transitionHandler: vc),
                          interactor: r.resolve(StartPageInteractorType.self)!,
                          validatorFactory: r.resolve(ValidatorFactoryType.self)!)
        }
        container.storyboardInitCompleted(StartPageViewController.self) { r, viewController in
            viewController.presenter = r.resolve(StartPagePresenter.self, argument: viewController)!
        }
    }
}
