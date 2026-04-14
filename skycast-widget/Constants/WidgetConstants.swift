//
//  WidgetConstants.swift
//  skycast-widgetkit
//
//  Created by Grigory G. on 13.03.26.
//

import Foundation

enum WidgetConstants {
    
    // MARK: - Widget Info
    enum Info {
        static let kind = "skycast_widget"
        static let displayName = "SkyCast Weather"
        static let description = "Keep track of weather"
    }
    
    // MARK: - Preview Data
    enum Preview {
        static let cityYerevan = CityWeatherEntity(
            name: "Yerevan",
            temperature: 22,
            condition: .clear,
            date: .now,
            timeZoneIdentifier: "Asia/Yerevan"
        )
        
        static let citySanFrancisco = CityWeatherEntity(
            name: "San Francisco",
            temperature: 25,
            condition: .rain,
            date: .now,
            timeZoneIdentifier: "America/Los_Angeles"
        )
        
        static let cityMoscow = CityWeatherEntity(
            name: "Moscow",
            temperature: 18,
            condition: .cloudy,
            date: .now,
            timeZoneIdentifier: "Europe/Moscow"
        )
        
        static let cityLondon = CityWeatherEntity(
            name: "London",
            temperature: 20,
            condition: .partlyCloudy,
            date: .now,
            timeZoneIdentifier: "Europe/London"
        )
    }
    
    // MARK: - Preview Sets
    enum PreviewSets {
        
        static let small: WeatherEntry = WeatherEntry(
            date: .now,
            cities: [
                Preview.cityYerevan
            ],
            backgroundMode: .blue
        )
        
        static let medium: WeatherEntry = WeatherEntry(
            date: .now,
            cities: [
                Preview.cityYerevan,
                Preview.citySanFrancisco
            ],
            backgroundMode: .dark
        )
        
        static let large: WeatherEntry = WeatherEntry(
            date: .now,
            cities: [
                Preview.cityYerevan,
                Preview.citySanFrancisco,
                Preview.cityMoscow,
                Preview.cityLondon
            ],
            backgroundMode: .blue
        )
    }
}

// MARK: - Provider Logic
extension WidgetConstants {
    
    enum Provider {
        static let updateIntervalMinutes = 30
        static let maxCities = 4
        
        static let loadingCity = CityWeatherEntity(
            name: "Loading",
            temperature: 0,
            condition: .clear,
            date: .now,
            timeZoneIdentifier: TimeZone.current.identifier
        )
        
        static let noDataCity = CityWeatherEntity(
            name: "No Data",
            temperature: 0,
            condition: .unknown,
            date: .now,
            timeZoneIdentifier: TimeZone.current.identifier
        )
    }
}

// MARK: - Entry View
extension WidgetConstants {
    
    enum EntryView {
        
        enum Text {
            static let connectionLost = "Connection Lost"
            static let retry = "Retry"
            static let message = "Please check your internet settings and try again."
        }
        
        enum Icons {
            static let wifiError = "wifi.exclamationmark"
        }
        
        enum Layout {
            static let mediumCityCount = 2
            static let largeCityCount = 4
        }
    }
}

// MARK: - UI Layout
extension WidgetConstants {
    
    enum Layout {
        static let leadingPadding: CGFloat = 8
        static let horizontalSpacing: CGFloat = 12
        static let verticalSpacing: CGFloat = 12
        static let gridCornerRadius: CGFloat = 18
        static let gridOpacity: Double = 0.12
        static let headerFontSize: CGFloat = 12
    }
    
    enum Text {
        static let title = "SKYCAST"
    }
    
    enum Style {
        static let headerKerning: CGFloat = 1.2
        static let headerOpacity: CGFloat = 0.7
        static let defaultSpacing: CGFloat = 6
        static let verticalPadding: CGFloat = 16
    }
    
    enum Grid {
        static let rows = 2
        static let columns = 2
    }
}

// MARK: - Storage
extension WidgetConstants {
    
    enum Storage {
        static let suiteName = "group.com.grigory.skycast-widgetkit"
        static let dataKey = "weather_widget_data"
    }
}
