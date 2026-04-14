//
//  WeatherDashboardGridView.swift
//  skycast-widgetkit
//
//  Created by Grigory G. on 13.03.26.
//

import SwiftUI

// MARK: - Large Widget View
/// Grid view optimized for .systemLarge
struct WeatherDashboardGridView: View {
    
    // MARK: - Properties
    let cities: [CityWeatherEntity]
    
    // MARK: - Body
    var body: some View {
        VStack(spacing: WidgetConstants.Layout.verticalSpacing) {
            SkycastHeaderView()
            
            /// Grid layout
            Grid(verticalSpacing: WidgetConstants.Layout.verticalSpacing) {
                
                ForEach(0..<WidgetConstants.Grid.rows, id: \.self) { rowIndex in
                    GridRow {
                        ForEach(0..<WidgetConstants.Grid.columns, id: \.self) { colIndex in
                            let index = rowIndex * 2 + colIndex
                            if index < cities.count {
                                WeatherStatCell(model: cities[index], style: .prominent)
                                    .padding(.leading, WidgetConstants.Layout.horizontalSpacing)
                                    .frame(maxWidth: .infinity, maxHeight: .infinity) // Grow to fill
                                    .background(Color.white.opacity(WidgetConstants.Layout.gridOpacity))
                                    .clipShape(RoundedRectangle(cornerRadius: WidgetConstants.Layout.gridCornerRadius))
                            }
                        }
                    }
                }
            }
        }
        .padding(0)
    }
}
