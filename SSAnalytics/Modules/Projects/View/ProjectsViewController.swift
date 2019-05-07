//
//  ProjectsViewController.swift
//  SSAnalytics
//
//  Created by StartupSoft Mac6 on 4/30/19.
//  Copyright © 2019 startupsoft. All rights reserved.
//

import Foundation
import UIKit
import STT

class ProjectsViewController: SttViewController<ProjectsPresenter>, ProjectsViewDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var noDataLabel: UILabel!
    @IBOutlet weak var doneButton: UIButton!
    
    var tableViewSource: ProjectTableViewSource!
    
    var del: WorkLogFilterViewDelegate!
    
    override func viewDidLoad() {
        self.useErrorLabel = false
        super.viewDidLoad()
        initialSetup()
    }
    
    var set: SttBindingSet<ProjectsViewController>!
    override func bind() {
        set = SttBindingSet(parent: self)
        
        tableViewSource = ProjectTableViewSource(tableView: tableView, collection: presenter.projects)
        set.bind(doneButton).to(presenter.done)
        set.bind(Bool.self).forProperty({ $0.noDataLabel.isHidden = !$1 }).to(presenter.isEmpty)
        set.apply()
        
        presenter.getData.useWork(handler: { [unowned self] (status) in
            self.noDataLabel.isHidden = status
        }).disposed(by: presenter.listenerDisposableBag)
        presenter.getData.useIndicator(view: tableView).disposed(by: presenter.listenerDisposableBag)
    }
    
    // MARK: - implementation of ProjectsViewDelegate
    func addProjectsToCollectionView() {
        if let parent = del as? WorkLogFilterViewController {
//            parent.presenter.clear.execute()
            parent.addProjects(projects: presenter.projects.compactMap({ (project) in
                if project.isSelected.value {
                    return .init(id: project.id.value, name: project.name.value)
                }
                return nil
            }))
            parent.presenter.projects.forEach({ $0.parent = parent.presenter })
            parent.projectsTextField.endEditing(true)
        }
    }
    
    func selectProjectsWhichWereSelected(projects: [ProjectTableViewCellPresenter]) {
        presenter.selectedProjects.append(contentsOf: projects)
    }
    
}
