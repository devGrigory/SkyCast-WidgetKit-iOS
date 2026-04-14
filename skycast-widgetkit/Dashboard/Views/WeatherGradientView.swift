//
//  WeatherGradientView.swift
//  skycast-widgetkit
//
//  Created by Grigory G. on 10.03.26.
//

import SwiftUI

// MARK: - Weather Gradient View
struct WeatherGradientView: View {
    
    // MARK: - Properties
    let condition: WeatherCondition
    
    // MARK: - Body
    var body: some View {
        LinearGradient(
            colors: colors,
            startPoint: .top,
            endPoint: .bottom
        )
    }
}

// MARK: - Gradient
private extension WeatherGradientView {
    
    var colors: [Color] {
        switch condition {
        case .clear:
            return [.blue, .cyan]
            
        case .cloudy:
            return [
                .gray.opacity(0.4),
                .blue.opacity(0.6)
            ]
            
        case .rain:
            return [
                .blue.opacity(0.8),
                .indigo.opacity(0.6)
            ]
            
        case .snow:
            return [.white, .blue]
            
        default:
            return [.blue, .cyan]
        }
    }
}
