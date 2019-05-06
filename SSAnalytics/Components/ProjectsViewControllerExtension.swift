//
//  ProjectsViewControllerExtension.swift
//  SSAnalytics
//
//  Created by StartupSoft Mac6 on 5/3/19.
//  Copyright © 2019 startupsoft. All rights reserved.
//

import UIKit

extension ProjectsViewController {
    func initialSetup() {
        tableView.tableFooterView = UIView(frame: CGRect(x: 0, y: 0, width: tableView.bounds.width, height: 1))
        
        doneButton.layer.cornerRadius = 15
        doneButton.layer.borderColor = UIColor.black.cgColor
        doneButton.layer.borderWidth = 2
    }
}
