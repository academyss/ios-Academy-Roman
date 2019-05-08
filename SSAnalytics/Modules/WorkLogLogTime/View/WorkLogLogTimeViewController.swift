//
//  WorkLogLogTimeViewController.swift
//  SSAnalytics
//
//  Created by StartupSoft Mac6 on 4/22/19.
//  Copyright © 2019 startupsoft. All rights reserved.
//

import Foundation
import UIKit
import STT

class WorkLogLogTimeViewController: SttViewController<WorkLogLogTimePresenter>, WorkLogLogTimeViewDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var noDataLabel: UILabel!
    @IBOutlet weak var emptyView: UIView!
    
    var source: WorkLogTimeTableViewSource!
    
    lazy var refreshControl: UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action:
            #selector(handleRefresh(_:)),
                                 for: UIControl.Event.valueChanged)
        refreshControl.tintColor = UIColor.clear
        
        return refreshControl
    }()
    
    override func viewDidLoad() {
        self.useErrorLabel = false
        super.viewDidLoad()
        tableView.tableFooterView = UIView(frame: CGRect(x: 0, y: 0, width: tableView.bounds.width, height: 1))
        tableView.addSubview(refreshControl)
    }
    
    var set: SttBindingSet<WorkLogLogTimeViewController>!
    override func bind() {
        set = SttBindingSet(parent: self)
        
        source = WorkLogTimeTableViewSource(tableView: tableView, collection: presenter.itemsCollection)
        
        set.bind(Bool.self).forProperty({ $0.emptyView.isHidden = !$1 }).to(presenter.isEmpty)
        
        set.apply()
        
        presenter.download.useIndicator(view: tableView).disposed(by: presenter.listenerDisposableBag)
        presenter.download.useWork(handler: { [weak self] (status) in
            self?.emptyView.isHidden = status
        }).disposed(by: presenter.listenerDisposableBag)
    }
    
    
    // MARK: - implementation of WorkLogLogTimeViewDelegate
    
    func updateTableView() {
        
        self.tableView.reloadData()
        var selectedSection = presenter.itemsCollection.index { (item) in
            if item.0.contains(where: { $0.isSelected.value == true }) {
                return true
            }
            return false
        }
        var selectedRow: Int?
        if let sSection = selectedSection {
            selectedRow = presenter.itemsCollection[sSection].0.index(where: { $0.isSelected.value == true })
        }
        
        if let row = selectedRow, let section = selectedSection {
            let indexPath = IndexPath(row: row, section: section)
            guard let cell = tableView.cellForRow(at: indexPath) else { return }
            
            if tableView.visibleCells.last == cell {
                self.tableView.scrollToRow(at: indexPath, at: .bottom, animated: true)
            }
        }
    }
    
    func passParameterToPage(param: WorkLogDiaryRequestApiModel) {
        presenter.filterObject.value = param
    }
    
    @objc func handleRefresh(_ refreshControl: UIRefreshControl) {
        self.presenter.download.execute()
        refreshControl.endRefreshing()
    }
}
