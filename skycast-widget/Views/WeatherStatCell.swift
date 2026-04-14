//
//  WeatherStatCell.swift
//  skycast-widgetkit
//
//  Created by Grigory G. on 14.03.26.
//

import SwiftUI

// MARK: - Reusable Weather Cell
struct WeatherStatCell: View {
    
    // MARK: - Properties
    let model: CityWeatherEntity
    let style: WeatherViewStyle
    
    // MARK: - Body
    var body: some View {
        VStack(alignment: style == .prominent ? .leading : .center, spacing: WidgetConstants.Style.defaultSpacing) {
            
            Text(model.name)
                .font(.system(size: style == .prominent ? 14 : 12, weight: .semibold))
                .opacity(0.8)
            Spacer()
            HStack(alignment: .center, spacing: WidgetConstants.Style.defaultSpacing) {
                
                Image(systemName: model.systemIcon)
                    .font(.system(size: style == .prominent ? 24 : 16))
                
                Text("\(Int(model.temperature.rounded()))°")
                    .font(.system(size: style == .prominent ? 42 : 22, weight: .black))
            }
        }
        .padding(.vertical, WidgetConstants.Style.verticalPadding)
        .foregroundColor(.white)
        .frame(maxWidth: .infinity, alignment: style == .prominent ? .leading : .center)
    }
}
