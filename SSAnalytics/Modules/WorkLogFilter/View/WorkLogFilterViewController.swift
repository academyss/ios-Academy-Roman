//
//  WorkLogFilterViewController.swift
//  SSAnalytics
//
//  Created by StartupSoft Mac6 on 4/30/19.
//  Copyright © 2019 startupsoft. All rights reserved.
//

import Foundation
import UIKit
import STT


class WorkLogFilterViewController: SttKeyboardViewController<WorkLogFilterPresenter>, WorkLogFilterViewDelegate, UIPopoverPresentationControllerDelegate {
    
    @IBOutlet weak var clearButton: UIButton!
    @IBOutlet weak var filterButton: UIButton!
    @IBOutlet weak var cancelButton: UIButton!
    @IBOutlet weak var projectsTextField: SttTextField!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var approvedSwitch: UISwitch!
    @IBOutlet weak var rejectedSwitch: UISwitch!
    @IBOutlet weak var pendingSwitch: UISwitch!
    @IBOutlet weak var collectionViewHeight: NSLayoutConstraint!
    @IBOutlet weak var startDateInputView: SttTextField!
    @IBOutlet weak var endDateInputView: SttTextField!
    @IBOutlet weak var noDataLabel: UILabel!
    
    
    
    var startDatePicker = UIDatePicker()
    var endDatePicker = UIDatePicker()
    
    var collectionViewSource: ProjectCollectionViewSource!
    var projectsTextFieldHandler: SttHandlerTextField!
    
	override func viewDidLoad() {
        self.useErrorLabel = false
        super.viewDidLoad()
        initialSetup()
        configureCollectionView()
	}
    
    
    
    var set: SttBindingSet<WorkLogFilterViewController>!
    override func bind() {
        set = SttBindingSet(parent: self)
        
        collectionViewSource = ProjectCollectionViewSource(collectionView: collectionView, collection: presenter.projects)
        
        set.bind(clearButton).to(presenter.clear)
        set.bind(cancelButton).to(presenter.close)
        
        set.bind(startDatePicker).to(presenter.startDate)
        set.bind(endDatePicker).to(presenter.endDate)
        
        set.bind(startDateInputView).to(presenter.startDate)
            .withMode(.readBind)
            .withConverter(DateForDatePickerConverter.self)
        
        set.bind(endDateInputView).to(presenter.endDate)
            .withMode(.readBind)
            .withConverter(DateForDatePickerConverter.self)
        
        set.bind(filterButton).to(presenter.filter)
        set.bind(Bool.self).forProperty({ $0.noDataLabel.isHidden = !$1 }).to(presenter.isEmpty)
        
        
        set.apply()
        
        
        
    }
    
	// MARK: - implementation of WorkLogFilterViewDelegate
        
    func adaptivePresentationStyle(for controller: UIPresentationController) -> UIModalPresentationStyle {
        return .none
    }
    
    func addProjects(projects: [ProjectCollectionViewCellPresenter]) {
        presenter.addProjects.execute(parametr: projects)
    }
    
    func setMinDate(date: Date) {
        endDatePicker.minimumDate = date
    }
   
    @objc func onSwitchValueChanged(sender: UISwitch) {
        switch sender {
        case approvedSwitch:
            presenter.approved.value.toggle()
        case pendingSwitch:
            presenter.pending.value.toggle()
        case rejectedSwitch:
            presenter.rejected.value.toggle()
        default:
            fatalError()
        }
    }
    
}

