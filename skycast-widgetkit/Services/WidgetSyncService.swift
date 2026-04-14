//
//  WidgetSyncService.swift
//  skycast-widgetkit
//
//  Created by Grigory G. on 13.03.26.
//

import WidgetKit

// MARK: - Widget Sync Service
final class WidgetSyncService {
    
    // MARK: - Singleton
    static let shared = WidgetSyncService()
    
    private init() {}
}

extension WidgetSyncService {
    
    // MARK: - Instant Update
    func pushUpdate(cities: [CityWeatherEntity]) {
        
        let data = WidgetWeatherData(
            cities: cities,
            date: Date()
        )
        
        WidgetStorage.shared.save(data)
        
        /// Ask system to refresh widgets
        WidgetCenter.shared.reloadAllTimelines()
    }
}
