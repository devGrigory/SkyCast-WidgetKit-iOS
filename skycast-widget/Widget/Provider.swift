//
//  Provider.swift
//  skycast-widgetkit
//
//  Created by Grigory G. on 12.03.26.
//

import WidgetKit
import AppIntents

// MARK: - Timeline Provider
struct Provider: AppIntentTimelineProvider {
    
    // MARK: - Type Aliases
    typealias Entry = WeatherEntry
    typealias Intent = ConfigurationAppIntent
    
    // MARK: - Placeholder
    func placeholder(in context: Context) -> WeatherEntry {
        WeatherEntry(
            date: Date(),
            cities: [
                WidgetConstants.Provider.loadingCity
            ],
            backgroundMode: .blue
        )
    }
    
    // MARK: Snapshot
    func snapshot(for configuration: ConfigurationAppIntent, in context: Context) async -> WeatherEntry {
        loadEntry(mode: configuration.theme)
    }
    
    // MARK: Timeline
    func timeline(for configuration: ConfigurationAppIntent, in context: Context) async -> Timeline<WeatherEntry> {
        
        let entry = loadEntry(mode: configuration.theme)
        
        let nextUpdate = Calendar.current.date(byAdding: .minute, value: 30, to: Date()) ?? .now
        
        return Timeline(entries: [entry], policy: .after(nextUpdate))
    }
    
    // MARK: Load Entry
    private func loadEntry(mode: WidgetBackgroundMode) -> WeatherEntry {
        
        guard let data = WidgetStorage.shared.load() else {
            return WeatherEntry(
                date: Date(),
                cities: [
                    WidgetConstants.Provider.noDataCity
                ],
                backgroundMode: mode
            )
        }
        
        return WeatherEntry(
            date: data.date,
            cities: Array(data.cities.prefix(4)),
            backgroundMode: mode
        )
    }
}
