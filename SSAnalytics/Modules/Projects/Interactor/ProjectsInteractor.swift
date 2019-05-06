//
//  ProjectsInteractor.swift
//  SSAnalytics
//
//  Created by StartupSoft Mac6 on 4/30/19.
//  Copyright © 2019 startupsoft. All rights reserved.
//

import Foundation
import RxSwift
import STT

final class ProjectsInteractor: ProjectsInteractorType {
    
    private let _workLogRepository: WorkLogRepositoryType
    private let _notificationErrorService: SttNotificationErrorServiceType
    
    init(workLogRepository: WorkLogRepositoryType, notificationErrorService: SttNotificationErrorServiceType) {
        _workLogRepository = workLogRepository
        _notificationErrorService = notificationErrorService
    }
    func getMyProjects(projectName: String) -> Observable<[ProjectTableViewCellPresenter]> {
        return _workLogRepository.getMyProjects(projectName: projectName)
            .map({ $0.convertToViewModel() })
    }
}
