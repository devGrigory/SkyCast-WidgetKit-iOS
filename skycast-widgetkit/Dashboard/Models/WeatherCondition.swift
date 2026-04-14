//
//  WeatherCondition.swift
//  skycast-widgetkit
//
//  Created by Grigory G. on 13.03.26.
//

import Foundation

// MARK: - Weather Condition
enum WeatherCondition: String, Codable {
    case clear
    case cloudy
    case partlyCloudy
    case rain
    case snow
    case thunderstorm
    case fog
    case unknown
}

// MARK: - Initialization
extension WeatherCondition {
    
    // MARK: - API Mapping
    init(_ string: String) {
        switch string.lowercased() {
        case "clear", "sunny":
            self = .clear
        case "cloudy":
            self = .cloudy
        case "partly cloudy", "partly_cloudy", "partly-cloudy":
            self = .partlyCloudy
        case "rain", "rainy":
            self = .rain
        case "snow":
            self = .snow
        case "thunderstorm":
            self = .thunderstorm
        case "fog", "mist":
            self = .fog
        default:
            self = .unknown
        }
    }
}

// MARK: - Display
extension WeatherCondition {
    
    // MARK: - Display Name
    /// Human-readable string (UI / widget usage)
    var displayName: String {
        switch self {
        case .clear: return Constants.ConditionStrings.clear
        case .cloudy: return Constants.ConditionStrings.cloudy
        case .partlyCloudy: return Constants.ConditionStrings.partlyCloudy
        case .rain: return Constants.ConditionStrings.rain
        case .snow: return Constants.ConditionStrings.snow
        case .thunderstorm: return Constants.ConditionStrings.thunderstorm
        case .fog: return Constants.ConditionStrings.fog
        case .unknown: return Constants.ConditionStrings.unknown
        }
    }
}
