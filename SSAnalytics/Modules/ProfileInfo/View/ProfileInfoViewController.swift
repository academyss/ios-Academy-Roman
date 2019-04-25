//
//  ProfileInfoViewController.swift
//  SSAnalytics
//
//  Created by StartupSoft Mac6 on 4/22/19.
//  Copyright © 2019 startupsoft. All rights reserved.
//

import Foundation
import UIKit
import STT

class ProfileInfoViewController: SttViewController<ProfileInfoPresenter>, ProfileInfoViewDelegate {
    
    @IBOutlet weak var avatarImageView: CachedImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var rolesLabel: UILabel!
    
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var phoneLabel: UILabel!
    @IBOutlet weak var skypeLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initialSetup()
	}
    
    var set: SttBindingSet<ProfileInfoViewController>!
    override func bind() {
        set = SttBindingSet(parent: self)
        
        set.bind(avatarImageView).to(presenter.avatar)
        set.bind(nameLabel).to(presenter.name)
        set.bind(rolesLabel).to(presenter.roles)
        set.bind(emailLabel).to(presenter.email)
        set.bind(phoneLabel).to(presenter.phone)
        set.bind(skypeLabel).to(presenter.skype)
        set.bind(String.self).forProperty({ $0.title = $1}).to(presenter.name)
        
        set.apply()
    }
    
    func initialSetup() {
        avatarImageView.layer.cornerRadius = avatarImageView.bounds.width / 2
        avatarImageView.placeholderType = .avatar
        rolesLabel.textColor = UIColor(named: "LightGray")
    }

	// MARK: - implementation of ProfileInfoViewDelegate
}
