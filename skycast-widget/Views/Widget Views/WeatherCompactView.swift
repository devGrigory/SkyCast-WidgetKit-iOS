//
//  WeatherCompactView.swift
//  skycast-widgetkit
//
//  Created by Grigory G. on 13.03.26.
//

import SwiftUI

// MARK: - Compact Widget View
/// Compact view optimized for .systemSmall
struct WeatherCompactView: View {
    
    // MARK: - Properties
    let city: CityWeatherEntity
    
    // MARK: - Body
    var body: some View {
        VStack(alignment: .leading) {
            
            SkycastHeaderView()
            
            Spacer()
            
            WeatherStatCell(model: city, style: .prominent)
            
            Spacer()
        }
        .padding(.leading, WidgetConstants.Layout.leadingPadding)
    }
}
