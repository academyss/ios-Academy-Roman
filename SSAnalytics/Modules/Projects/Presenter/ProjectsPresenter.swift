//
//  ProjectsPresenter.swift
//  SSAnalytics
//
//  Created by StartupSoft Mac6 on 4/30/19.
//  Copyright © 2019 startupsoft. All rights reserved.
//

import Foundation
import STT
import RxSwift

final class ProjectsPresenter: SttPresenter<ProjectsViewDelegate> {
    
    private let _router: ProjectsRouterType
    private let _interactor: ProjectsInteractorType
    
    var projects = SttObservableCollection<ProjectTableViewCellPresenter>()
    var selectedProjects = SttObservableCollection<ProjectTableViewCellPresenter>()
    
    private(set) lazy var getData = SttComandWithParametr(delegate: self, handler: { $0.onGetData($1) })
    private(set) lazy var done = SttCommand(delegate: self, handler: { $0.onDone() })
    
    let disposeBag = DisposeBag()
    let isEmpty = Dynamic(true)
    
    init(view: SttViewable, notificationService: SttNotificationErrorServiceType, router: ProjectsRouterType,
         interactor: ProjectsInteractorType) {
        
        _router = router
        _interactor = interactor
        
        super.init(notificationError: notificationService)
        super.injectView(delegate: view)
    }
    
    private var firstStart = true
    override func viewAppeared() {
        super.viewAppeared()
        
        if firstStart {
            firstStart = false
            
            projects.observableObject.useWork(getData)
                .subscribe(onNext: { [unowned self] _ in
                    self.isEmpty.value = self.projects.isEmpty
                }).disposed(by: disposeBag)
        }
    }
    
    override func viewAppearing() {
        super.viewAppearing()
        getData.execute(parametr: "")
        
    }
    
    
    override func viewDissapearing() {
        delegate?.addProjectsToCollectionView()
    }
    
    func onGetData(_ projectName: String) {
        _interactor.getMyProjects(projectName: projectName)
            .subscribe(onNext: { [unowned self] projects in
                self.projects.append(contentsOf: projects)
                self.projects.forEach({ project in
                    if self.selectedProjects.contains(where: { $0.id.value == project.id.value }) {
                        project.isSelected.value = true
                    }
                })
                }, onError: { [unowned self] error in
                    if let err = error as? SttBaseError {
                        self.delegate?.sendError(error: err)
                    }
            }).disposed(by: disposeBag)
    }
    
    func onDone() {
        _router.close(animate: true)
    }
}
