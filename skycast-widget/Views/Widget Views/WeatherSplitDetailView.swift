//
//  WeatherSplitDetailView.swift
//  skycast-widgetkit
//
//  Created by Grigory G. on 13.03.26.
//

import SwiftUI

// MARK: - Medium Widget View
/// Split view optimized for .systemMedium
struct WeatherSplitDetailView: View {
    
    // MARK: - Properties
    let cities: [CityWeatherEntity]
    
    // MARK: - Body
    var body: some View {
        VStack {
            
            SkycastHeaderView()
            
            HStack(spacing: 0) {
                ForEach(Array(cities.prefix(WidgetConstants.EntryView.Layout.mediumCityCount).enumerated()), id: \.element.id) { index, city in
                    
                    WeatherStatCell(model: city, style: .prominent)
                        .padding(.horizontal, WidgetConstants.Layout.horizontalSpacing)
                        .frame(maxWidth: .infinity)
                    
                    if index == 0 {
                        Divider()
                            .background(Color.white.opacity(0.3))
                            .padding(.vertical, WidgetConstants.Layout.verticalSpacing)
                    }
                }
            }
        }
        .padding(.leading, WidgetConstants.Layout.leadingPadding)
    }
}
