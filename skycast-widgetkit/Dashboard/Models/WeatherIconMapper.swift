//
//  WeatherIconMapper.swift
//  skycast-widgetkit
//
//  Created by Grigory G. on 13.03.26.
//

import Foundation

// MARK: - Weather Icon Mapper
enum WeatherIconMapper {
    
    // MARK: - Public API
    static func icon(
        for condition: WeatherCondition,
        date: Date,
        timeZone: TimeZone
    ) -> String {
        
        var calendar = Calendar.current
        calendar.timeZone = timeZone
        
        let hour = calendar.component(.hour, from: date)
        
        let isNight =
        hour < Constants.Card.sunriseHour ||
        hour >= Constants.Card.sunsetHour
        
        return Constants.WeatherIcon.name(
            for: condition,
            isNight: isNight
        )
    }
}
