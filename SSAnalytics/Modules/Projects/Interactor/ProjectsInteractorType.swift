//
//  ProjectsInteractorType.swift
//  SSAnalytics
//
//  Created by StartupSoft Mac6 on 4/30/19.
//  Copyright © 2019 startupsoft. All rights reserved.
//

import Foundation
import RxSwift

protocol ProjectsInteractorType {
    func getMyProjects(projectName: String) -> Observable<[ProjectTableViewCellPresenter]>
}
