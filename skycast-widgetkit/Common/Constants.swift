//
//  Constants.swift
//  skycast-widgetkit
//
//  Created by Grigory G. on 11.03.26.
//

import Foundation

// MARK: - Constants Root

enum Constants {
    
    // MARK: - UI Text
    
    enum Text {
        static let title = "SkyCast"
        static let subtitle = "Live weather across cities"
        static let locating = "Locating..."
        static let errorIcon = "exclamationmark.triangle"
        static let locationIcon = "location.fill"
    }
    
    // MARK: - Layout
    enum Layout {
        static let mainSpacing: CGFloat = 16
        static let headerSpacing: CGFloat = 6
        static let cornerRadius: CGFloat = 12
        static let loadingBoxSize: CGFloat = 48
        static let topPadding: CGFloat = 0
        static let verticalPadding: CGFloat = 40
    }
}

// MARK: - Card UI

extension Constants {
    
    enum Card {
        
        // MARK: - UI
        
        static let currentLocationLabel = "Current location"
        static let timeFormat = "EEEE, HH:mm"
        static let localeIdentifier = "en_US_POSIX"
        
        // MARK: - Layout
        
        static let minHeight: CGFloat = 150
        static let cornerRadius: CGFloat = 16
        static let iconSize: CGFloat = 40
        static let tempFontSize: CGFloat = 32
        static let innerPadding: CGFloat = 16
        
        // MARK: - Timing & Logic
        
        static let refreshInterval: Double = 60
        static let sunsetHour = 20
        static let sunriseHour = 6
    }
}
    
// MARK: - Weather Icon
extension Constants {
    
    enum WeatherIcon: String {
        case sunMax = "sun.max.fill"
        case moonStars = "moon.stars.fill"
        case cloudSun = "cloud.sun.fill"
        case cloudMoon = "cloud.moon.fill"
        case rain = "cloud.rain.fill"
        case snow = "cloud.snow.fill"
        case bolt = "cloud.bolt.fill"
        case fog = "cloud.fog.fill"
        
        // MARK: - Mapping
        
        static func name(for condition: WeatherCondition, isNight: Bool) -> String {
            switch condition {
                
            case .clear:
                return isNight ? moonStars.rawValue : sunMax.rawValue
                
            case .cloudy:
                return isNight ? cloudMoon.rawValue : cloudSun.rawValue
                
            case .partlyCloudy:
                return cloudSun.rawValue   // or cloudMoon if you want night variation
                
            case .rain:
                return rain.rawValue
                
            case .snow:
                return snow.rawValue
                
            case .thunderstorm:
                return bolt.rawValue
                
            case .fog:
                return fog.rawValue
                
            case .unknown:
                return isNight ? cloudMoon.rawValue : cloudSun.rawValue
            }
        }
        
    }
}

// MARK: - ViewModel

extension Constants {
    enum ViewModel {
        
        // MARK: - Defaults
        
        static let defaultCity = "Unknown City"
        static let defaultCountry = "Unknown Country"
        
        // MARK: - Errors
        
        static let errorPrefix = "Failed to load weather data: "
        
        // MARK: - Timing
        /// How often to poll for fresh weather data (seconds)
        static let pollingInterval: Double = 60
    }
}

// MARK: - API

extension Constants {
    
    // MARK: - API
    static let baseURL = "https://api.open-meteo.com/v1/forecast"
    
    enum Query {
        static let latitude = "latitude"
        static let longitude = "longitude"
        static let currentWeather = "current_weather"
    }
    
    enum WeatherCodes {
        static let clear = 0
        static let partlyCloudy = [1, 2]
        static let cloudy = 3
        static let fog = [45, 48]
        static let drizzle = [51, 53, 55]
        static let rain = [61, 63, 65]
        static let snow = [71, 73, 75]
        static let thunderstorm = 95
    }
    
    enum ConditionStrings {
        static let clear = "clear"
        static let cloudy = "cloudy"
        static let partlyCloudy = "partly cloudy"
        static let rain = "rain"
        static let snow = "snow"
        static let thunderstorm = "thunderstorm"
        static let fog = "fog"
        static let unknown = "unknown"
    }
}
