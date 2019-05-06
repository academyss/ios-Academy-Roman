//
//  ProjectTableViewCellPresenter.swift
//  SSAnalytics
//
//  Created by StartupSoft Mac6 on 4/30/19.
//  Copyright © 2019 startupsoft. All rights reserved.
//

import Foundation
import STT

final class ProjectTableViewCellPresenter: SttPresenter<ProjectTableViewCellViewDelegate> {
    
    weak var parent: ProjectTableViewCellDelegate!
    
    let id = Dynamic<String>("")
    let name = Dynamic<String>("")
    let isSelected = Dynamic<Bool>(false)
    
    private(set) lazy var select = SttCommand(delegate: self, handler: { $0.onClick() })
    
    init(id: String, name: String) {
        self.id.value = id
        self.name.value = name
        super.init(notificationError: nil)
    }
    
    func onClick() {
        isSelected.value.toggle()
    }
}
