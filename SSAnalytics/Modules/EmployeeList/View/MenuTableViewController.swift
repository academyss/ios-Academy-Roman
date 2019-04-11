//
//  MenuTableViewController.swift
//  SSAnalytics
//
//  Created by StartupSoft Mac6 on 4/9/19.
//  Copyright © 2019 startupsoft. All rights reserved.
//

import UIKit

class MenuTableViewController: UITableViewController {

    @IBOutlet weak var employeesCell: UITableViewCell!
    @IBOutlet weak var dashboardCell: UITableViewCell!
    @IBOutlet weak var projectsCell: UITableViewCell!
    @IBOutlet weak var workLogCell: UITableViewCell!
    @IBOutlet weak var vacationCell: UITableViewCell!
    @IBOutlet weak var responsibilitiesCell: UITableViewCell!
    @IBOutlet weak var logOutCell: UITableViewCell!
    @IBOutlet weak var userAvatarImage: UIImageView!
    @IBOutlet weak var userNameLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureCells()
        userAvatarImage.layer.cornerRadius = userAvatarImage.bounds.width / 2
    }


    func configureCells() {
        let backgroundView = UIView()
        backgroundView.backgroundColor = UIColor.black
        tableView.tableFooterView = backgroundView
        backgroundView.backgroundColor = UIColor.darkGray
        employeesCell.selectedBackgroundView = backgroundView
        dashboardCell.selectedBackgroundView = backgroundView
        projectsCell.selectedBackgroundView = backgroundView
        workLogCell.selectedBackgroundView = backgroundView
        vacationCell.selectedBackgroundView = backgroundView
        responsibilitiesCell.selectedBackgroundView = backgroundView
        logOutCell.selectedBackgroundView = backgroundView
    }
}
