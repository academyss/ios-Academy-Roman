//
//  EmployeeListViewController.swift
//  SSAnalytics
//
//  Created by StartupSoft Mac6 on 4/5/19.
//  Copyright © 2019 startupsoft. All rights reserved.
//

import Foundation
import UIKit
import STT
import SideMenu

class EmployeeListViewController: SttViewController<EmployeeListPresenter>, EmployeeListViewDelegate {
    
    @IBOutlet weak var employeesTableView: UITableView!
    
    var menuBarButton: UIBarButtonItem?
    var searchBarButton: UIBarButtonItem?
    var searchBar: UISearchBar!
    var employees: CellTableViewSource!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureNavigationBar()
        configureTableView()
        configureSideMenu()
        searchBar = UISearchBar()
    }
    
    var set: SttBindingSet<EmployeeListViewController>!
    
    override func bind() {
        super.bind()
        employees = CellTableViewSource(tableView: employeesTableView, collection: presenter.employeesCollection)
        set = SttBindingSet(parent: self)
        set.bind(String.self).forProperty({ $0.searchBar.text = $1 }).to(presenter.searchString)
        
        set.apply()
    }
    
    private func configureSideMenu() {
    
        SideMenuManager.default.menuLeftNavigationController = storyboard!.instantiateViewController(withIdentifier: "LeftMenuNavigationController") as? UISideMenuNavigationController
        SideMenuManager.default.menuWidth = view.bounds.width * 0.8
        
    }
    
    private func configureNavigationBar() {
        self.navigationItem.hidesBackButton = true
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(image: #imageLiteral(resourceName: "MenuIcon").withRenderingMode(.alwaysOriginal), style: .plain, target: self, action: #selector(showEmployeeMenu))
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(image: #imageLiteral(resourceName: "SearchIcon").withRenderingMode(.alwaysOriginal), style: .plain, target: self, action: #selector(showSearchBar))
        self.title = "Employees"
    }
    
    private func configureTableView() {
        employeesTableView.tableFooterView = UIView()
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
