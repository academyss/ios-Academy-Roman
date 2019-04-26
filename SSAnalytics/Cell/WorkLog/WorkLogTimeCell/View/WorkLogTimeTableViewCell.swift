//
//  WorkLogTimeTableViewCell.swift
//  SSAnalytics
//
//  Created by StartupSoft Mac6 on 4/24/19.
//  Copyright © 2019 startupsoft. All rights reserved.
//

import Foundation
import UIKit
import STT

class WorkLogTimeTableViewCell: SttTableViewCell<WorkLogTimeTableViewCellPresenter>, WorkLogTimeTableViewCellViewDelegate {
    
    static let reusableIdentifier = "WorkLogTimeTableViewCell"
    
    @IBOutlet weak var detailsView: UIView!
    @IBOutlet weak var projectNameLabel: UILabel!
    @IBOutlet weak var spendedTimeLabel: UILabel!
    
    @IBOutlet weak var describtionLabel: UILabel!
    @IBOutlet weak var startTimeLabel: UILabel!
    @IBOutlet weak var statusLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    var set: SttBindingSet<WorkLogTimeTableViewCell>!
    
    override func prepareBind() {
        super.prepareBind()
        
        set = SttBindingSet(parent: self)
        
        set.bind(projectNameLabel).to(presenter.projectName)
        set.bind(spendedTimeLabel).to(presenter.spendedTime)
        set.bind(describtionLabel).to(presenter.describtion)
        set.bind(startTimeLabel).to(presenter.startTime)
        set.bind(statusLabel).to(presenter.status)
        
        set.bind(Bool.self).forProperty({ $0.detailsView.isHidden = $1 })
            .to(presenter.isSelected)
        set.bind(tap()).to(presenter.select)

        
        set.apply()
    }
    
    // MARK: - implementation of WorkLogTimeTableViewCellViewDelegate
}
