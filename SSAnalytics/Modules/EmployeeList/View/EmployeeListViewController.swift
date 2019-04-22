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
    
    func updateTableView() {
        employeesTableView.beginUpdates()
        employeesTableView.endUpdates()
    }
    
}
