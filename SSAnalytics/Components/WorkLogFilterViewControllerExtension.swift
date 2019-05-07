//
//  WorkLogFilterViewControllerExtension.swift
//  SSAnalytics
//
//  Created by StartupSoft Mac6 on 5/6/19.
//  Copyright © 2019 startupsoft. All rights reserved.
//

import UIKit
import STT

extension WorkLogFilterViewController {
    
    func initialSetup() {
        
        self.title = "Work Log Filter"
        
        startDatePicker.datePickerMode = .date
        endDatePicker.datePickerMode = .date
        
        let calendar = Calendar(identifier: .gregorian)
        
        let currentDate = Date()
        var components = DateComponents()
        components.calendar = calendar
        
        components.year = -3
        let minDate = calendar.date(byAdding: components, to: currentDate)!
        print(currentDate)
        startDatePicker.maximumDate = Date()
        startDatePicker.minimumDate = minDate
        endDatePicker.maximumDate = Date()
        
        startDateInputView.tintColor = UIColor.clear
        endDateInputView.tintColor = UIColor.clear
        startDateInputView.inputView = startDatePicker
        endDateInputView.inputView = endDatePicker
        
        projectsTextField.tintColor = UIColor.clear
        projectsTextField.inputView = UIView()
        projectsTextField.delegate = projectsTextFieldHandler
        
        clearButton.layer.cornerRadius = 15
        clearButton.setBorder(color: .black, size: 1)
        
        filterButton.layer.cornerRadius = filterButton.bounds.height / 2
        filterButton.tintColor = .white
        filterButton.backgroundColor = UIColor(named: "Blue")
        
        cancelButton.layer.cornerRadius = cancelButton.bounds.height / 2
        cancelButton.setBorder(color: .black, size: 1)
        
        projectsTextFieldHandler = SttHandlerTextField(projectsTextField)
        
        projectsTextFieldHandler.addTarget(type: .didStartEditing, delegate: self, handler: { (self, textField) in
            
            let projectsController = UIStoryboard(name: "Application", bundle: nil).instantiateViewController(withIdentifier: "Projects") as! ProjectsViewController
            projectsController.del = self
            projectsController.selectProjectsWhichWereSelected(projects: self.presenter.projects.map({ ProjectTableViewCellPresenter(id: $0.id.value, name: $0.name.value) }))
            projectsController.modalPresentationStyle = .popover
            projectsController.popoverPresentationController?.permittedArrowDirections = .up
            projectsController.popoverPresentationController?.sourceView = self.projectsTextField
            projectsController.popoverPresentationController?.delegate = self
            let myRect = self.projectsTextField.bounds
            projectsController.popoverPresentationController?.sourceRect = myRect
            self.presenter.projects.removeAll()
            self.present(projectsController,animated: true,completion: nil)
        })
        
        
        approvedSwitch.addTarget(self, action: #selector(onSwitchValueChanged(sender:)), for: .valueChanged)
        pendingSwitch.addTarget(self, action: #selector(onSwitchValueChanged(sender:)), for: .valueChanged)
        rejectedSwitch.addTarget(self, action: #selector(onSwitchValueChanged(sender:)), for: .valueChanged)
    }
    
    func configureCollectionView() {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.sectionInset = UIEdgeInsets(top: 1, left: 1, bottom: 1, right: 1)
        layout.minimumLineSpacing = 1.0
        layout.minimumInteritemSpacing = 5.0
        collectionView.setCollectionViewLayout(layout, animated: false)
        
        collectionView.reloadData()
    }
    
}
