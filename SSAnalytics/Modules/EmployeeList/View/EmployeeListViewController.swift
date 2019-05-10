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
    @IBOutlet weak var noDataLabel: UILabel!
    
    var searchBar: UISearchBar!
    var menuBarButton: UIBarButtonItem!
    var searchBarButton: UIBarButtonItem!
    var employees: CellTableViewSource!
    var searchBarHandler: SttHanlderSearchBar!
    
    override func viewDidLoad() {
        self.useErrorLabel = false
        super.viewDidLoad()
        initialSetup()
        configureNavigationBar()
        configureTableView()
        configureSideMenu()
        UIView.appearance().isExclusiveTouch = true
    }
    
    
    
    var set: SttBindingSet<EmployeeListViewController>!
    
    override func bind() {
        super.bind()
        
        employees = CellTableViewSource(tableView: employeesTableView, collection: presenter.employeesCollection)
        
        set = SttBindingSet(parent: self)
        
        set.bind(String.self).forProperty({ $0.searchBar.text = $1 }).to(presenter.searchString)
        
        set.bind(Bool.self).forProperty({ $0.noDataLabel.isHidden = !$1 }).to(presenter.isEmpty)
        
        set.apply()
        
        presenter.download.useIndicator(view: employeesTableView)
            .disposed(by: presenter.listenerDisposableBag)
        presenter.refresh.useRefresh(scrollView: employeesTableView)
            .disposable.disposed(by: presenter.listenerDisposableBag)
        
        presenter.refresh.useWork(handler: { [unowned self] (status) in
            self.noDataLabel.isHidden = status
        }).disposed(by: presenter.listenerDisposableBag)
        presenter.download.useWork(handler: { [unowned self] (status) in
            self.noDataLabel.isHidden = status
        }).disposed(by: presenter.listenerDisposableBag)
        
    }
    
    func updateTableView() {
        self.employeesTableView.reloadData()
        let selectedRow = presenter.employeesCollection.index(where: { $0.isSelected.value == true })
        if let row = selectedRow {
            let indexPath = IndexPath(row: row, section: 0)
            guard let cell = employeesTableView.cellForRow(at: indexPath) else { return }
            
            if employeesTableView.visibleCells.last == cell {
                self.employeesTableView.scrollToRow(at: indexPath, at: .bottom, animated: true)
            }
        }
    }
    
    func endSearch() {
        searchBar.endEditing(true)
    }
    
    @objc func handleRefresh(_ refreshControl: UIRefreshControl) {
        self.presenter.download.execute()
        refreshControl.endRefreshing()
    }
    
    
    
}
