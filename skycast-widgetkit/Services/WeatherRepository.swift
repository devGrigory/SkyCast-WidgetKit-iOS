//
//  WeatherRepository.swift
//  skycast-widgetkit
//
//  Created by Grigory G. on 14.03.26.
//

import SwiftUI

// MARK: - Weather Repository

final class WeatherRepository {
    
    // MARK: - Dependencies
    let service: WeatherServicing
    
    init(service: WeatherServicing) {
        self.service = service
    }
}

extension WeatherRepository {
    
    // MARK: - Featured Cities
    func fetchFeaturedCities() async -> [CityWeatherViewModel] {
        await withTaskGroup(of: (Int, CityWeatherViewModel?).self) { group in
            
            for (index, config) in CityConfig.staticCities.enumerated() {
                group.addTask {
                    let model = try? await self.fetchWeatherModel(
                        lat: config.lat,
                        lon: config.lon,
                        city: config.name,
                        country: config.country,
                        timeZone: config.timeZone
                    )
                    return (index, model)
                }
            }
            
            var results = [Int: CityWeatherViewModel]()
            for await (index, model) in group {
                if let model = model {
                    results[index] = model
                }
            }
            
            return results.sorted(by: { $0.key < $1.key }).map { $0.value }
        }
    }
}

extension WeatherRepository {
    
    // MARK: - Current Weather
    func fetchWeather(lat: Double, lon: Double) async throws -> WeatherDTO {
        try await service.fetchWeather(lat: lat, lon: lon)
    }
}

private extension WeatherRepository {
    
    // MARK: - Weather Model Builder
    private func fetchWeatherModel(
        lat: Double,
        lon: Double,
        city: String,
        country: String,
        timeZone: TimeZone? = nil,
        isCurrent: Bool = false
    ) async throws -> CityWeatherViewModel {
        let dto = try await service.fetchWeather(lat: lat, lon: lon)
        return CityWeatherViewModel(
            city: city,
            country: country,
            temperature: dto.temperature,
            condition: WeatherCondition(dto.condition),
            date: Date(),
            timeZone: timeZone ?? .current,
            isCurrentLocation: isCurrent,
            lat: lat,
            lon: lon
        )
    }
}
