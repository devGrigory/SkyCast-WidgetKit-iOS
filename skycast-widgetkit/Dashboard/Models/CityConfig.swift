//
//  CityConfig.swift
//  skycast-widgetkit
//
//  Created by Grigory G. on 13.03.26.
//

import Foundation

// MARK: - City Configuration
struct CityConfig {
    
    // MARK: - Properties
    let name: String
    let country: String
    let lat: Double
    let lon: Double
    let timeZone: TimeZone?
}

// MARK: - Static Data
extension CityConfig {
    
    // MARK: - Static Cities
    static let staticCities = [
        CityConfig(
            name: "San Francisco",
            country: "USA",
            lat: 37.7749,
            lon: -122.4194,
            timeZone: TimeZone(identifier: "America/Los_Angeles")
        ),
        CityConfig(
            name: "Moscow",
            country: "Russia",
            lat: 55.7558,
            lon: 37.6173,
            timeZone: TimeZone(identifier: "Europe/Moscow")
        ),
        CityConfig(
            name: "London",
            country: "UK",
            lat: 51.5072,
            lon: -0.1276,
            timeZone: TimeZone(identifier: "Europe/London")
        )
    ]
}
