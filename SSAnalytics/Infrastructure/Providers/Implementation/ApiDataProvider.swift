//
//  ApiDataProvider.swift
//  SSAnalytics
//
//  Created by Peter Standret on 3/14/19.
//  Copyright © 2019 startupsoft. All rights reserved.
//

import Foundation
import RxSwift
import STT

final class ApiDataProvider: ApiDataProviderType {
    
    
    
    private var _httpService: SttHttpServiceType!
    
    init (httpService: SttHttpServiceType) {
        _httpService = httpService
    }
    
    // MARK: - ACCOUNT
    
    
    func getToken(data: SignInApiModel) -> Observable<TokenApiModel> {
        return _httpService.post(controller: ApiConroller.token,
                                 data: ["grant_type" : "password",
                                          "username" : data.email,
                                          "password" : data.password], insertToken: false)
            .getResult()
    }
    
    func getUsersByInput(input: String) -> Observable<[EmployeeApiModel]> {
        return _httpService.get(controller: ApiConroller.users("GetUsersByInput"),
                                data: ["input" : input], insertToken: true)
            .getResult()
    }
    
    func getUsersById(userId: String) -> Observable<UserApiModel> {
        return _httpService.get(controller: ApiConroller.users("GetUsersById"),
                                data: ["UserId" : userId], insertToken: true)
            .getResult()
    }
    
    func getWorkLogStatistics(date: String) -> Observable<WorkLogStatisticApiModel> {
        return _httpService.get(controller: ApiConroller.workLog("statistic"),
                                data: ["date" : date], insertToken: true)
        .getResult()
    }
    
    func getWorkLogDiary(data: WorkLogDiaryRequestApiModel) -> Observable<[WorkLogDiaryResponseApiModel]> {
        return _httpService.get(controller: ApiConroller.workLog("workLogDiary"),
                                data: ["startDate" : data.startDate,
                                       "endDate" : data.endDate,
                                       "projectsId" : data.projectsId,
                                       "workLogStatuses" : data.workLogStatuses], insertToken: true)
        .getResult()
    }
    
    func getMyProjects(projectName: String) -> Observable<ProjectApiModel> {
        return _httpService.get(controller: ApiConroller.project("myProjects"),
                                data: ["projectName": projectName], insertToken: true)
        .getResult()
    }
    
}
