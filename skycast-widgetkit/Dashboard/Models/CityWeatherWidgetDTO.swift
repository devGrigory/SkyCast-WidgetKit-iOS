//
//  CityWeatherWidgetDTO.swift
//  skycast-widgetkit
//
//  Created by Grigory G. on 13.03.26.
//

import Foundation

// MARK: - Widget DTO
struct CityWeatherWidgetDTO: Codable, Identifiable {
    
    // MARK: - Properties
    let id: UUID
    let name: String
    let temperature: Int
    let condition: WeatherCondition
    let date: Date
    let timeZoneIdentifier: String
}
