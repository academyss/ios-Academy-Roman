//
//  ProjectTableViewCell.swift
//  SSAnalytics
//
//  Created by StartupSoft Mac6 on 4/30/19.
//  Copyright © 2019 startupsoft. All rights reserved.
//

import Foundation
import UIKit
import STT

class ProjectTableViewCell: SttTableViewCell<ProjectTableViewCellPresenter>, ProjectTableViewCellViewDelegate {

    static let reusableIdentifier = "ProjectTableViewCell"
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var isSelectedImageView: UIImageView!
    
	override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    var set: SttBindingSet<ProjectTableViewCell>!
	override func prepareBind() {
        	super.prepareBind()
        set = SttBindingSet(parent: self)
        set.bind(nameLabel).to(presenter.name)
        set.bind(Bool.self).forProperty({ $0.isSelectedImageView.isHidden = !$1 })
            .to(presenter.isSelected)
        set.bind(tap()).to(presenter.select)
        set.apply()
    }

    // MARK: - implementation of ProjectTableViewCellViewDelegate
}
