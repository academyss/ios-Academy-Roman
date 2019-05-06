//
//  ProfileInfoViewControllerExtension.swift
//  SSAnalytics
//
//  Created by StartupSoft Mac6 on 5/3/19.
//  Copyright © 2019 startupsoft. All rights reserved.
//

import UIKit


extension ProfileInfoViewController {
    func initialSetup() {
        avatarImageView.layer.cornerRadius = avatarImageView.bounds.width / 2
        avatarImageView.placeholderType = .avatar
        rolesLabel.textColor = UIColor(named: "LightGray")
    }
}
