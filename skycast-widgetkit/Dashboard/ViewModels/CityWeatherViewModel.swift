//
//  CityWeatherViewModel.swift
//  skycast-widgetkit
//
//  Created by Grigory G. on 13.03.26.
//

import Foundation
import Combine

// MARK: - Weather View Model
final class CityWeatherViewModel: ObservableObject {
    
    // MARK: - Properties (Static)
    let city: String
    let country: String
    let timeZone: TimeZone
    let isCurrentLocation: Bool
    let lat: Double
    let lon: Double

    // MARK: - Properties (Reactive)
    @Published private(set) var temperature: Double
    @Published var condition: WeatherCondition
    @Published var date: Date

    // MARK: - Initialization
    init(
        city: String,
        country: String,
        temperature: Double,
        condition: WeatherCondition,
        date: Date,
        timeZone: TimeZone,
        isCurrentLocation: Bool,
        lat: Double,
        lon: Double
    ) {
        self.city = city
        self.country = country
        self.temperature = temperature
        self.condition = condition
        self.date = date
        self.timeZone = timeZone
        self.isCurrentLocation = isCurrentLocation
        self.lat = lat
        self.lon = lon
    }
}

extension CityWeatherViewModel {
    
    // MARK: - Display
    var temperatureText: String {
        "\(Int(temperature.rounded()))°C"
    }
}
