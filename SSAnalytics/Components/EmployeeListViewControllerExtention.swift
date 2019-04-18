//
//  EmployeeListViewControllerExtention.swift
//  SSAnalytics
//
//  Created by StartupSoft Mac6 on 4/18/19.
//  Copyright © 2019 startupsoft. All rights reserved.
//

import Foundation
import SideMenu

extension EmployeeListViewController {
    
     func configureSideMenu() {
        SideMenuManager.default.menuLeftNavigationController = storyboard!.instantiateViewController(withIdentifier: "LeftMenuNavigationController") as? UISideMenuNavigationController
        SideMenuManager.default.menuWidth = view.bounds.width * 0.8
        SideMenuManager.default.menuDismissOnPush = true
    }
    
    func configureNavigationBar() {
        self.navigationItem.leftBarButtonItem = menuBarButton
        self.navigationItem.rightBarButtonItem = searchBarButton
        self.navigationItem.titleView = nil
    }
    
    func configureTableView() {
        employeesTableView.tableFooterView = UIView()
        employeesTableView.keyboardDismissMode = UIScrollView.KeyboardDismissMode.onDrag
    }
    
    @objc func showEmployeeMenu() {
        present(SideMenuManager.default.menuLeftNavigationController!, animated: true, completion: nil)
    }
    
    
    @objc func showSearchBar() {
        self.navigationItem.leftBarButtonItem = nil
        self.navigationItem.rightBarButtonItem = nil
        self.searchBar.showsCancelButton = true
        navigationItem.titleView = searchBar
        searchBar.becomeFirstResponder()
    }
    
}
