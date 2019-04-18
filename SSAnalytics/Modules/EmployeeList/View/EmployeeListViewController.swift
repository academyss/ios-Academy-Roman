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
        set.bind(String.self).forProperty({ $0.searchBar.text = $1 }).to(presenter.searchString)
        
        set.apply()
        
        presenter.download.useIndicator(view: employeesTableView)
            .disposed(by: presenter.listenerDisposableBag)
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
    
    
}
