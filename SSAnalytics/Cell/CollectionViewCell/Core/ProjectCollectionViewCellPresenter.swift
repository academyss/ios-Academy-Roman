//
//  ProjectCollectionViewCellPresenter.swift
//  SSAnalytics
//
//  Created by StartupSoft Mac6 on 4/30/19.
//  Copyright © 2019 startupsoft. All rights reserved.
//

import Foundation
import STT

final class ProjectCollectionViewCellPresenter: SttPresenter<ProjectCollectionViewCellViewDelegate> {
    
    weak var parent: ProjectCollectionViewCellDelegate!
    
    let name = Dynamic<String>("")
    let id = Dynamic<String>("")
    
    private(set) lazy var delete = SttCommand(delegate: self, handler: { $0.onDelete() })
    
    init(id: String, name: String) {
        self.id.value = id
        self.name.value = name
        super.init(notificationError: nil)
    }
    
    func onDelete() {
        parent.deleteObject(id: id.value)
    }
}
