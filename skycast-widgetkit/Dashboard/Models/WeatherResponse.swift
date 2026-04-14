//
//  WeatherResponse.swift
//  skycast-widgetkit
//
//  Created by Grigory G. on 10.03.26.
//

import Foundation

// MARK: - API Response Model

/// The top-level response from the Open-Meteo API
struct Response: Decodable {
    
    // MARK: - Properties
    let current_weather: CurrentWeather
}
