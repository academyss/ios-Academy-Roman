//
//  ProjectCollectionViewCell.swift
//  SSAnalytics
//
//  Created by StartupSoft Mac6 on 4/30/19.
//  Copyright © 2019 startupsoft. All rights reserved.
//

import Foundation
import UIKit
import STT

class ProjectCollectionViewCell: SttCollectionViewCell<ProjectCollectionViewCellPresenter>, ProjectCollectionViewCellViewDelegate {
    
    static let reusableIdentifier = "ProjectCollectionViewCell"
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var view: UIView!
    @IBOutlet weak var deleteButton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        view.layer.borderColor = UIColor.black.cgColor
        view.layer.borderWidth = 2
    }
    
    var set: SttBindingSet<ProjectCollectionViewCell>!
    override func prepareBind() {
        super.prepareBind()
        set =  SttBindingSet(parent: self)
        set.bind(nameLabel).to(presenter.name)
        set.bind(deleteButton).to(presenter.delete)
        set.apply()
    }
    
    // MARK: - implementation of ProjectCollectionViewCellViewDelegate
}
