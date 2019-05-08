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
  
    
    @IBOutlet weak var callButton: UIButton!
    @IBOutlet weak var emailButton: UIButton!
    
    override func viewDidLoad() {
        self.useErrorLabel = false
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
         
        set.bind(phoneLabel.tap()).to(presenter.call)
        set.bind(emailLabel.tap()).to(presenter.sendEmail)
        
        set.bind(String.self).forProperty({ $0.title = $1}).to(presenter.name)
        
        set.bind(emailButton).to(presenter.sendEmail)
        set.bind(callButton).to(presenter.call)
        
        set.apply()
    }

	// MARK: - implementation of ProfileInfoViewDelegate
}
