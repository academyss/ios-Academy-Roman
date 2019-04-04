//
//  BaseRepository.swift
//  SSAnalytics
//
//  Created by Peter Standret on 3/14/19.
//  Copyright © 2019 startupsoft. All rights reserved.
//

import Foundation

class BaseRepository {
    
    private(set) var _apiDataProvider: ApiDataProviderType!
    private(set) var _keyValueStorageProvider: KeyValueStorageType!
    
    init (apiDataProvider: ApiDataProviderType, keyValueStorageProvider: KeyValueStorageType) {
        self._apiDataProvider = apiDataProvider
        self._keyValueStorageProvider = keyValueStorageProvider
    }
}
