//
//  WeatherService.swift
//  skycast-widgetkit
//
//  Created by Grigory G. on 10.03.26.
//

import CoreLocation

// MARK: - Weather Service Protocol
protocol WeatherServicing {
    func fetchWeather(lat: Double, lon: Double) async throws -> WeatherDTO
}

// MARK: - Service Implementation
final class WeatherService: WeatherServicing {
    
    // MARK: - Public API
    func fetchWeather(lat: Double, lon: Double) async throws -> WeatherDTO {
        
        var components = URLComponents(string: Constants.baseURL)
        components?.queryItems = [
            URLQueryItem(name: Constants.Query.latitude, value: "\(lat)"),
            URLQueryItem(name: Constants.Query.longitude, value: "\(lon)"),
            URLQueryItem(name: Constants.Query.currentWeather, value: "true")
        ]
        
        guard let url = components?.url else {
            throw URLError(.badURL)
        }
        
        let (data, response) = try await URLSession.shared.data(from: url)
        
        guard let httpResponse = response as? HTTPURLResponse,
              200...299 ~= httpResponse.statusCode else {
            throw URLError(.badServerResponse)
        }
        
        let decoded = try JSONDecoder().decode(Response.self, from: data)
        
        return WeatherDTO(
            temperature: decoded.current_weather.temperature,
            condition: Self.mapWeatherCode(decoded.current_weather.weatherCode)
        )
    }
}

// MARK: - Mapping Logic
extension WeatherService {
    
    // MARK: - Weather Code Mapping
    static func mapWeatherCode(_ code: Int) -> String {
        switch code {
        case Constants.WeatherCodes.clear:
            return Constants.ConditionStrings.clear
            
        case let c where Constants.WeatherCodes.partlyCloudy.contains(c):
            return Constants.ConditionStrings.cloudy
            
        case Constants.WeatherCodes.cloudy:
            return Constants.ConditionStrings.cloudy
            
        case let c where Constants.WeatherCodes.fog.contains(c):
            return Constants.ConditionStrings.fog
            
        case let c where Constants.WeatherCodes.drizzle.contains(c):
            return Constants.ConditionStrings.rain
            
        case let c where Constants.WeatherCodes.rain.contains(c):
            return Constants.ConditionStrings.rain
            
        case let c where Constants.WeatherCodes.snow.contains(c):
            return Constants.ConditionStrings.snow
            
        case Constants.WeatherCodes.thunderstorm:
            return Constants.ConditionStrings.thunderstorm
            
        default:
            return Constants.ConditionStrings.clear
        }
    }
}
