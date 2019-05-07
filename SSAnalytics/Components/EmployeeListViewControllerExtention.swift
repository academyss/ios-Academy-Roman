//
//  EmployeeListViewControllerExtention.swift
//  SSAnalytics
//
//  Created by StartupSoft Mac6 on 4/18/19.
//  Copyright © 2019 startupsoft. All rights reserved.
//

import Foundation
import SideMenu
import STT

extension EmployeeListViewController {
    
    func initialSetup() {
        self.title = "Employees"
        navigationController?.navigationBar.tintColor = .black
        self.navigationItem.hidesBackButton = true
        self.menuBarButton = UIBarButtonItem(image: UIImage(named: "MenuIcon")!.withRenderingMode(.alwaysOriginal), style: .plain, target: self, action: #selector(showEmployeeMenu))
        self.searchBarButton = UIBarButtonItem(image: UIImage(named: "SearchIcon")!.withRenderingMode(.alwaysOriginal), style: .plain, target: self, action: #selector(showSearchBar))
        
        self.searchBar = UISearchBar()
        self.searchBarHandler = SttHanlderSearchBar()
        searchBar.delegate = searchBarHandler
        self.searchBarHandler.addTarget(type: .textDidChange, delegate: self) { (v, sb) in
            v.presenter.searchString.value = sb.text
        }
        self.searchBarHandler.addTarget(type: .shouldBeginEditing, delegate: self, handler: { (v, sb) in
            v.presenter.searchString.value = sb.text
        })
        self.searchBarHandler.addTarget(type: .searchButtonClicked, delegate: self) { (view, sb) in
            view.presenter.download.execute()
            sb.endEditing(true)
        }
        self.searchBarHandler.addTarget(type: .cancelClicked, delegate: self) { (view, sb) in
            sb.text = ""
            view.presenter.searchString.value = ""
            self.configureNavigationBar()
        }
    }
    
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
        employeesTableView.tableFooterView = UIView(frame: CGRect(x: 0, y: 0, width: employeesTableView.bounds.width, height: 1))
        employeesTableView.keyboardDismissMode = UIScrollView.KeyboardDismissMode.onDrag
    }
    
    @objc func showEmployeeMenu() {
//        if !SideMenuManager.defaultManager.menuLeftNavigationController!.isBeingDismissed {
//            SideMenuManager.defaultManager.menuLeftNavigationController?.dismiss(animated: false, completion: nil)
//        }
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
