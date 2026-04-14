//
//  WidgetStorage.swift
//  skycast-widgetkit
//
//  Created by Grigory G. on 13.03.26.
//

import Foundation

// MARK: - Widget Data Model
struct WidgetWeatherData: Codable {
    
    // MARK: - Properties
    let cities: [CityWeatherEntity]
    let date: Date
}

// MARK: - Storage Layer
final class WidgetStorage {

    // MARK: - Singleton
    static let shared = WidgetStorage()

    // MARK: - Configuration
    private let suiteName = WidgetConstants.Storage.suiteName
    private let key = WidgetConstants.Storage.dataKey

    // MARK: - UserDefaults
    private var defaults: UserDefaults? {
        UserDefaults(suiteName: suiteName)
    }

    // MARK: Save
    func save(_ data: WidgetWeatherData) {
        guard let defaults else { return }

        do {
            let encoded = try JSONEncoder().encode(data)
            defaults.set(encoded, forKey: key)
        } catch {
            print("❌ WidgetStorage save error:", error)
        }
    }

    // MARK: Load
    func load() -> WidgetWeatherData? {
        guard let defaults,
              let data = defaults.data(forKey: key)
        else { return nil }

        do {
            return try JSONDecoder().decode(WidgetWeatherData.self, from: data)
        } catch {
            print("❌ WidgetStorage decode error:", error)
            return nil
        }
    }

    // MARK: - Clear
    func clear() {
        guard let defaults else { return }
        defaults.removeObject(forKey: key)
    }
}
