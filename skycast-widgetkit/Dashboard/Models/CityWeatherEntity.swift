//
//  CityWeatherEntity.swift
//  skycast-widgetkit
//
//  Created by Grigory G. on 14.03.26.
//

import Foundation

// MARK: - Entity
struct CityWeatherEntity: Codable, Identifiable {
    
    // MARK: - Properties
    let id: UUID
    let name: String
    let temperature: Double
    let condition: WeatherCondition
    let date: Date
    let timeZoneIdentifier: String
    let country: String
    let lat: Double
    let lon: Double
    let isCurrentLocation: Bool
    
    // MARK: - Initialization
    init(
        id: UUID = UUID(),
        name: String,
        temperature: Double,
        condition: WeatherCondition,
        date: Date,
        timeZoneIdentifier: String,
        country: String = "",
        lat: Double = 0,
        lon: Double = 0,
        isCurrentLocation: Bool = false
    ) {
        self.id = id
        self.name = name
        self.temperature = temperature
        self.condition = condition
        self.date = date
        self.timeZoneIdentifier = timeZoneIdentifier
        self.country = country
        self.lat = lat
        self.lon = lon
        self.isCurrentLocation = isCurrentLocation
    }
}

//MARK: - Computed Properties
private extension CityWeatherEntity {
    
    var timeZone: TimeZone {
        TimeZone(identifier: timeZoneIdentifier) ?? .current
    }
}

extension CityWeatherEntity {
    var systemIcon: String {
        WeatherIconMapper.icon(
            for: condition,
            date: date,
            timeZone: timeZone
        )
    }
}

// MARK: - Mapper
enum CityWeatherMapper {
    
    static func toWidget(_ entity: CityWeatherEntity) -> CityWeatherWidgetDTO {
        CityWeatherWidgetDTO(
            id: entity.id,
            name: entity.name,
            temperature: Int(entity.temperature),
            condition: entity.condition,
            date: entity.date,
            timeZoneIdentifier: entity.timeZoneIdentifier
        )
    }
}
