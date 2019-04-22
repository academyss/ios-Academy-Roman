//
//  MenuPresenter.swift
//  SSAnalytics
//
//  Created by StartupSoft Mac6 on 4/15/19.
//  Copyright © 2019 startupsoft. All rights reserved.
//

import Foundation
import STT
import RxSwift

final class MenuPresenter: SttPresenter<MenuViewDelegate> {
    
    private let _router: MenuRouterType
    private let _interactor: MenuInteractorType
    
    let disposeBag = DisposeBag()
    
    private(set) lazy var getUser = SttCommand(delegate: self, handler: { $0.onStart() })
   
    var userName: Dynamic<String> = Dynamic("")
    var avatarImage: Dynamic<Image> = Dynamic(Image(data: nil, url: nil))
    
    init(view: SttViewable, notificationService: SttNotificationErrorServiceType, router: MenuRouterType,
         interactor: MenuInteractorType) {
        
        _router = router
        _interactor = interactor
        
        super.init(notificationError: notificationService)
        super.injectView(delegate: view)
    }
    
    override func viewAppearing() {
        getUser.execute()
    }
    
    func onStart() {
        _interactor.getCurrentUserInfo().useWork(getUser)
            .subscribe(onNext: { [unowned self] user in
                self.userName.value = user.data.name
                self.avatarImage.value = Image(data: nil, url: user.data.imageUrl)
            }).disposed(by: disposeBag)
    }
}
