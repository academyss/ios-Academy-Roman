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
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath.row {
        case 0:
            dismiss(animated: true, completion: nil)
        case 3:
            router.navigateWithId(storyboard: Storyboard.application, to: WorkLogPresenter.self, parametr: nil, typeNavigation: .push, animate: true)
        case 6:
            let alertController = UIAlertController(title: "Are you sure want to log out?", message: nil, preferredStyle: .alert)
            let okAction = UIAlertAction(title: "Log out", style: .destructive) { [unowned self] _ in
                self.router.navigateWithId(storyboard: Storyboard.start, to: StartPagePresenter.self, parametr: nil, typeNavigation: .push, animate: true)
            }
            let cancel = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
            alertController.addAction(cancel)
            alertController.addAction(okAction)
            present(alertController, animated: true, completion: nil)
        default:
            print(indexPath.row)
        }
        tableView.deselectRow(at: indexPath, animated: false)

    }
    
}
