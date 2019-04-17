//
//  MenuTableViewController.swift
//  SSAnalytics
//
//  Created by StartupSoft Mac6 on 4/16/19.
//  Copyright © 2019 startupsoft. All rights reserved.
//

import UIKit

class MenuTableViewController: UITableViewController {

    var router:SttRouter!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.tableFooterView = UIView()
        router = SttRouter(transitionHandler: self)
        tableView.tableFooterView = UIView()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath.row {
        case 6:
            router.navigateWithId(storyboard: Storyboard.start, to: StartPagePresenter.self, parametr: nil, typeNavigation: .push, animate: true)
            
        default:
            print(indexPath.row)
        }
    }
    
}
