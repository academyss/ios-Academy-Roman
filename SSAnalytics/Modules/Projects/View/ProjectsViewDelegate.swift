//
//  ProjectsViewDelegate.swift
//  SSAnalytics
//
//  Created by StartupSoft Mac6 on 4/30/19.
//  Copyright © 2019 startupsoft. All rights reserved.
//

import Foundation
import STT

protocol ProjectsViewDelegate: SttViewControlable {
    func addProjectsToCollectionView()
    func selectProjectsWhichWereSelected(projects: [ProjectTableViewCellPresenter])
}
