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
        
        set.bind(Bool.self).forProperty({ $0.noDataLabel.isHidden = !$1 }).to(presenter.isEmpty)
        
        set.apply()
        
        presenter.download.useIndicator(view: tableView).disposed(by: presenter.listenerDisposableBag)
        presenter.download.useWork(handler: { [weak self] (status) in
            self?.noDataLabel.isHidden = status
        }).disposed(by: presenter.listenerDisposableBag)
    }
    
    
    // MARK: - implementation of WorkLogLogTimeViewDelegate
    
    func updateTableView() {
        
        UIView.transition(with: tableView,
                          duration: 0.2,
                          options: .transitionCrossDissolve,
                          animations: { self.tableView.reloadData() })
    }
    
    func passParameterToPage(param: WorkLogDiaryRequestApiModel) {
        presenter.filterObject.value = param
    }
    
    @objc func handleRefresh(_ refreshControl: UIRefreshControl) {
        self.presenter.download.execute()
        refreshControl.endRefreshing()
    }
}
