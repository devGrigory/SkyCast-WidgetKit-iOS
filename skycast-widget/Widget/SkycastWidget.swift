//
//  skycast_widget.swift
//  skycast-widget
//
//  Created by Grigory G. on 11.03.26.
//

import AppIntents
import WidgetKit
import SwiftUI

// MARK: - SkyCast Widget
struct SkycastWidget: Widget {
    
    // MARK: - Configuration
    let kind: String = WidgetConstants.Info.kind
    
    // MARK: - Body
    var body: some WidgetConfiguration {
        AppIntentConfiguration(
            kind: kind,
            intent: ConfigurationAppIntent.self,
            provider: Provider()
        ) { entry in
            SkycastEntryView(entry: entry)
        }
        .configurationDisplayName(WidgetConstants.Info.displayName)
        .description(WidgetConstants.Info.description)
        .supportedFamilies([.systemSmall, .systemMedium, .systemLarge])
    }
}

// MARK: - Previews
#Preview(as: .systemSmall) {
    SkycastWidget()
} timeline: {
    WeatherEntry(
        date: .now,
        cities: [
            WidgetConstants.Preview.cityYerevan
        ],
        backgroundMode: .blue
    )
}

#Preview(as: .systemMedium) {
    SkycastWidget()
} timeline: {
    WeatherEntry(
        date: .now,
        cities: [
            WidgetConstants.Preview.cityYerevan,
            WidgetConstants.Preview.citySanFrancisco
        ],
        backgroundMode: .dark
    )
}

#Preview(as: .systemLarge) {
    SkycastWidget()
} timeline: {
    WeatherEntry(
        date: .now,
        cities: [
            WidgetConstants.Preview.cityYerevan,
            WidgetConstants.Preview.citySanFrancisco,
            WidgetConstants.Preview.cityMoscow,
            WidgetConstants.Preview.cityLondon
        ],
        backgroundMode: .blue
    )
}
