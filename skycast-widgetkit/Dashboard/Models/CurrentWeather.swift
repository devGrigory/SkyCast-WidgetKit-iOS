//
//  CurrentWeather.swift
//  skycast-widgetkit
//
//  Created by Grigory G. on 14.03.26.
//

import Foundation

// MARK: - Weather DTO
/// Data Transfer Object representing the weather data from the network
struct CurrentWeather: Decodable {
    
    // MARK: - Properties
    let temperature: Double
    let weatherCode: Int
    
    // MARK: - Coding Keys
    private enum CodingKeys: String, CodingKey {
        case temperature
        case weatherCode = "weathercode"
    }
}
