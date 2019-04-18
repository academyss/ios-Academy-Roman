//
//  MenuViewControllerExtension.swift
//  SSAnalytics
//
//  Created by StartupSoft Mac6 on 4/18/19.
//  Copyright © 2019 startupsoft. All rights reserved.
//

import Foundation
import UIKit

extension MenuViewController {
    
    func initialSetup() {
        avatarImageView.placeholderType = .avatar
        avatarImageView.layer.cornerRadius = avatarImageView.bounds.width / 2
    }
    
}

extension MenuTableViewController {
    
    func initialSetup() {
        let backgroundView = UIView(frame: CGRect(x: 0, y: 0, width: view.bounds.width, height: 2))
        backgroundView.backgroundColor = UIColor.black
        tableView.tableFooterView = backgroundView
    }
}
