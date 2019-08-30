//
//  ApplicationAssembly.swift
//  SSAnalytics
//
//  Created by Peter Standret on 3/14/19.
//  Copyright © 2019 startupsoft. All rights reserved.
//

import RxSwift
import Swinject
import SwinjectStoryboard
import STT

final class ApplicationAssembly {
    
    fileprivate static var _instance: ApplicationAssembly?
    fileprivate static func initInstance() {
        _instance = ApplicationAssembly()
    }
    
    static var instance: ApplicationAssembly {
        if _instance == nil {
            initInstance()
        }
        return _instance!
    }
    
    lazy var assembler: Assembler = Assembler([
        SharedAsembly(),
        
        StartPageModuleAssembler(),
        EmployeeListModuleAssembler(),
        MenuModuleAssembler(),
        ProfileInfoModuleAssembler(),
        WorkLogModuleAssembler(),
        WorkLogStatisticModuleAssembler(),
        WorkLogLogTimeModuleAssembler(),
        WorkLogFilterModuleAssembler(),
        ProjectsModuleAssembler()
        // There are other ModuleAssembler
        ])
    
    fileprivate init() { }
    init(with assemblies: [Assembly]) {
        assembler = Assembler(assemblies)
    }
    
}

final class SharedAsembly: Assembly {
    
    func assemble(container: Container) {
        
        container.register(SttNotificationErrorServiceType.self, factory: { _ in SttNotificationErrorService()})
            .inObjectScope(.container)
        
        container.register(SttHttpServiceType.self,
                           factory: { r in
                            SttHttpService(
                                url: Environment.configuration(.serverUrl) + Environment.configuration(.versionAPI),
                                timeout: .seconds(Constants.timeout),
                                tokenGetter: { Observable<String>.just(Constants.tokenPrefix + r.resolve(KeyValueStorageType.self)!.token.get().token) })
        })
            .inObjectScope(.container)
        
        // Data providers
        container.register(KeyValueStorageType.self, factory: { _ in KeyValueStorage() })
            .inObjectScope(.container)
        container.register(ApiDataProviderType.self, factory: { r in ApiDataProvider(httpService: r.resolve(SttHttpServiceType.self)!) })
            .inObjectScope(.container)
        
        
        registerFactories(container: container)
        registerRepositories(container: container)
        registerServices(container: container)
        registerCommonInteractor(container: container)
    }
    
    private func registerRepositories(container: Container) {
        
        container.register(AccountRepositoryType.self) { r in
            AccountRepository(apiDataProvider: r.resolve(ApiDataProviderType.self)!,
                              keyValueStorageProvider: r.resolve(KeyValueStorageType.self)! )}
        container.register(UsersRepositoryType.self) { r in
            UsersRepository(apiDataProvider: r.resolve(ApiDataProviderType.self)!,
                            keyValueStorageProvider: r.resolve(KeyValueStorageType.self)! )}
            .inObjectScope(.container)
        container.register(WorkLogRepositoryType.self) { r in
            WorkLogRepository(apiDataProvider: r.resolve(ApiDataProviderType.self)!,
                                        keyValueStorageProvider: r.resolve(KeyValueStorageType.self)!)
        }
        // Repositories registration
    }
    
    private func registerServices(container: Container) {        
        // Services registration
    }
    
    private func registerCommonInteractor(container: Container) {
        
        // Common interactors registration
        // Comon interactors share between two or more modules
    }
    
    private func registerFactories(container: Container) {
        
        container.register(ValidatorFactoryType.self, factory: { _ in ValidatorFactory() })
            .inObjectScope(.container)
        
        // Factories registration
    }
}

extension SwinjectStoryboard {
    
    @objc class func setup() {
        defaultContainer = ApplicationAssembly.instance.assembler.resolver as! Container
    }
    
}

extension ProcessInfo {
    var isTesting: Bool { return ProcessInfo.processInfo.environment["XCTestConfigurationFilePath"] != nil }
}
