//
//  MenuViewController.swift
//  SSAnalytics
//
//  Created by StartupSoft Mac6 on 4/15/19.
//  Copyright © 2019 startupsoft. All rights reserved.
//

import Foundation
import UIKit
import STT

class MenuViewController: SttViewController<MenuPresenter>, MenuViewDelegate {
    
    @IBOutlet weak var avatarImageView: CachedImageView!
    @IBOutlet weak var nameLabel: UILabel!
    
    override func viewDidLoad() {
        super.hideNavigationBar = true
        super.viewDidLoad()
        
    }
    
    var set: SttBindingSet<MenuViewController>!
    override func bind() {
        set = SttBindingSet(parent: self)
        set.bind(nameLabel).to(presenter.userName)
        set.bind(avatarImageView).to(presenter.avatarImage)
        set.apply()
    }
	// MARK: - implementation of MenuViewDelegate
}
