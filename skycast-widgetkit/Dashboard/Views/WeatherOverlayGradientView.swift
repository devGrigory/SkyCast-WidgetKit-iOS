//
//  WeatherOverlayGradientView.swift
//  skycast-widgetkit
//
//  Created by Grigory G. on 10.03.26.
//

import SwiftUI

// MARK: - Weather Overlay Gradient View
struct WeatherOverlayGradientView: View {
    
    // MARK: - Body
    var body: some View {
        LinearGradient(
            colors: [
                .black.opacity(0.15),
                .black.opacity(0.35)
            ],
            startPoint: .top,
            endPoint: .bottom
        )
    }
}
