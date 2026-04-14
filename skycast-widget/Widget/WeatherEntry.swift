//
//  WeatherEntry.swift
//  skycast-widgetkit
//
//  Created by Grigory G. on 12.03.26.
//

import WidgetKit

// MARK: - Timeline Entry
struct WeatherEntry: TimelineEntry {
    
    // MARK: - Properties
    let date: Date
    let cities: [CityWeatherEntity]
    let backgroundMode: WidgetBackgroundMode
}
