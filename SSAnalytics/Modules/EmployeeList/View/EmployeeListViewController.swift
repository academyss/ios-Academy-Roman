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
    
    var searchBar: UISearchBar!
    var menuBarButton: UIBarButtonItem!
    var searchBarButton: UIBarButtonItem!
    var employees: CellTableViewSource!
    var searchBarHandler: SttHanlderSearchBar!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initialSetup()
        configureNavigationBar()
        configureTableView()
        configureSideMenu()
    }
    
    var set: SttBindingSet<EmployeeListViewController>!
    
    override func bind() {
        super.bind()
        employees = CellTableViewSource(tableView: employeesTableView, collection: presenter.employeesCollection)
        
        set = SttBindingSet(parent: self)
        set.bind(String.self).forProperty({ $0.searchBar.text = $1; print($0); print($1) }).to(presenter.searchString)
        
        set.apply()
    }
    
    func initialSetup() {
        self.title = "Employees"
        self.navigationItem.hidesBackButton = true
        self.menuBarButton = UIBarButtonItem(image: UIImage(named: "MenuIcon")!.withRenderingMode(.alwaysOriginal), style: .plain, target: self, action: #selector(showEmployeeMenu))
        self.searchBarButton = UIBarButtonItem(image: UIImage(named: "SearchIcon")!.withRenderingMode(.alwaysOriginal), style: .plain, target: self, action: #selector(showSearchBar))

        self.searchBar = UISearchBar()
        self.searchBarHandler = SttHanlderSearchBar()
        searchBar.delegate = searchBarHandler
        self.searchBarHandler.addTarget(type: .textDidChange, delegate: self) { (v, sb) in
            v.presenter.searchString.value = sb.text
        }
        self.searchBarHandler.addTarget(type: .searchButtonClicked, delegate: self) { (view, sb) in
            sb.endEditing(true)
        }
        self.searchBarHandler.addTarget(type: .cancelClicked, delegate: self) { (view, sb) in
            sb.text = ""
            view.presenter.searchString.value = ""
            self.configureNavigationBar()
        }
    }
    
    private func configureSideMenu() {
    
        SideMenuManager.default.menuLeftNavigationController = storyboard!.instantiateViewController(withIdentifier: "LeftMenuNavigationController") as? UISideMenuNavigationController
        SideMenuManager.default.menuWidth = view.bounds.width * 0.8
        
    }
    
    private func configureNavigationBar() {
        self.navigationItem.leftBarButtonItem = menuBarButton
        self.navigationItem.rightBarButtonItem = searchBarButton
        self.navigationItem.titleView = nil
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
