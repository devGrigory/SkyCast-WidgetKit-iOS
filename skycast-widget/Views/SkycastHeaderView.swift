//
//  SkycastHeaderView.swift
//  skycast-widgetkit
//
//  Created by Grigory G. on 12.03.26.
//

import SwiftUI
import WidgetKit

// MARK: - View Style
/// Internal UI styling mode
enum WeatherViewStyle {
    case prominent  /// Used for main/primary display
    case secondary  /// Used for compact/grid display
}

// MARK: - Header View
struct SkycastHeaderView: View {
    
    // MARK: - Body
    var body: some View {
        HStack {
            Spacer()
            
            Text(WidgetConstants.Text.title)
                .font(.system(size: WidgetConstants.Layout.headerFontSize, weight: .black))
                .kerning(WidgetConstants.Style.headerKerning)
                .opacity(WidgetConstants.Style.headerOpacity)
            
            Spacer()
        }
        .foregroundColor(.white)
    }
}
