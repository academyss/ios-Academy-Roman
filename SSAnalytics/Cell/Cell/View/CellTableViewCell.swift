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
import TinyConstraints

class CellTableViewCell: SttTableViewCell<CellTableViewCellPresenter>, CellTableViewCellViewDelegate {
    
    @IBOutlet weak var showProfileButton: UIButton!
    @IBOutlet weak var makeCallButton: UIButton!
    @IBOutlet weak var sendMailButton: UIButton!
    
    @IBOutlet weak var avatarImageView: CachedImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var jobLabel: UILabel!
    
    @IBOutlet weak var commandsView: UIView!
    
    static let reusableIdentifier = "CellTableViewCell"
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        avatarImageView.placeholderType = .avatar
        avatarImageView.layer.cornerRadius = avatarImageView.bounds.width / 2
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
    }
    
    
    var set: SttBindingSet<CellTableViewCell>!
    override func prepareBind() {
        super.prepareBind()
        
        set = SttBindingSet(parent: self)
        
        set.bind(avatarImageView).to(presenter.avatarImage)
        set.bind(nameLabel).to(presenter.name)
        set.bind(jobLabel).to(presenter.job)
        
        set.bind(Bool.self).forProperty({ $0.commandsView.isHidden = $1 })
            .to(presenter.isSelected)
        set.bind(tap()).to(presenter.select)
        
        set.bind(showProfileButton).to(presenter.showProfile)
        set.bind(makeCallButton).to(presenter.call)
        set.bind(sendMailButton).to(presenter.sendEmail)
        
        
        set.apply()
    }
    
    // MARK: - implementation of CellTableViewCellViewDelegate
    
}
