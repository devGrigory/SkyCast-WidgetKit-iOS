//
//  SkycastEntryView.swift
//  skycast-widgetkit
//
//  Created by Grigory G. on 12.03.26.
//

import SwiftUI
import WidgetKit

// MARK: - Entry View
struct SkycastEntryView: View {
    
    // MARK: - Properties
    var entry: WeatherEntry
    @Environment(\.widgetFamily) var family

    // MARK: - Body
    var body: some View {
        Group {
            switch family {
            case .systemSmall:
                if let city = entry.cities.first {
                    WeatherCompactView(city: city)
                }
            case .systemMedium:
                WeatherSplitDetailView(cities: Array(entry.cities.prefix(WidgetConstants.EntryView.Layout.mediumCityCount)))
            case .systemLarge:
                WeatherDashboardGridView(cities: Array(entry.cities.prefix(WidgetConstants.EntryView.Layout.largeCityCount)))
            default:
                ContentUnavailableView {
                    Label(WidgetConstants.EntryView.Text.connectionLost,
                          systemImage: WidgetConstants.EntryView.Icons.wifiError)
                } description: {
                    Text(WidgetConstants.EntryView.Text.message)
                } actions: {
                    Button(WidgetConstants.EntryView.Text.retry) {
                        /// Reload logic here
                    }
                    .buttonStyle(.borderedProminent)
                }
            }
        }
        .containerBackground(for: .widget) {
            entry.backgroundMode.gradient
        }
    }
}
