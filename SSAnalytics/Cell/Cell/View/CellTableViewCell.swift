//
//  CellTableViewCell.swift
//  SSAnalytics
//
//  Created by Peter Standret on 3/14/19.
//  Copyright © 2019 startupsoft. All rights reserved.
//

import Foundation
import UIKit
import STT

class CellTableViewCell: SttTableViewCell<CellTableViewCellPresenter>, CellTableViewCellViewDelegate {
    
    @IBOutlet weak var avatarImageView: CachedImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var jobLabel: UILabel!
    
    
    static let reusableIdentifier = "CellTableViewCell"
    
    override func awakeFromNib() {
        super.awakeFromNib()
        avatarImageView.placeholderType = .avatar
        avatarImageView.layer.cornerRadius = avatarImageView.bounds.width / 2
    }
    
    
    
    var set: SttBindingSet<CellTableViewCell>!
    override func prepareBind() {
        super.prepareBind()
        
        set = SttBindingSet(parent: self)
        
        set.bind(avatarImageView).to(presenter.avatarImage)
        set.bind(nameLabel).to(presenter.name)
        set.bind(jobLabel).to(presenter.job)
        
        set.apply()
    }
    
    // MARK: - implementation of CellTableViewCellViewDelegate
    
}
