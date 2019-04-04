//
//  StartPagePresenter.swift
//  SSAnalytics
//
//  Created by Peter Standret on 3/14/19.
//  Copyright © 2019 startupsoft. All rights reserved.
//

import Foundation
import STT

final class StartPagePresenter: SttPresenter<StartPageViewDelegate> {
    
    private let _router: SttRouterType
    private let _interactor: StartPageInteractorType
    
    init(view: SttViewable, notificationService: SttNotificationErrorServiceType, router: SttRouterType,
         interactor: StartPageInteractorType) {
        
        _router = router
		_interactor = interactor
        
        super.init(notificationError: notificationService)
        super.injectView(delegate: view)
    }
}
