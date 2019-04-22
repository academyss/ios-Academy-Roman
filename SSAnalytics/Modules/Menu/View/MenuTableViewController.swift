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
        router = SttRouter(transitionHandler: self)
        initialSetup()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let cell = tableView.cellForRow(at: indexPath) {
            cell.contentView.backgroundColor = UIColor(named: "DarkGray")
        }
        switch indexPath.row {
        case 0:
            dismiss(animated: true, completion: nil)
        case 1:
            router.navigateWithId(storyboard: Storyboard.application, to: WorkLogPresenter.self, parametr: nil, typeNavigation: .push, animate: true)
        case 6:
            router.navigateWithId(storyboard: Storyboard.start, to: StartPagePresenter.self, parametr: nil, typeNavigation: .push, animate: true)
            
        default:
            print(indexPath.row)
        }
    }
    
}
