//
//  ConfigurationAppIntent.swift
//  skycast-widget
//
//  Created by Grigory G. on 11.03.26.
//

import WidgetKit
import AppIntents

// MARK: - Widget Configuration Intent
struct ConfigurationAppIntent: WidgetConfigurationIntent {

    // MARK: - Title
    static var title: LocalizedStringResource = "SkyCast Settings"

    // MARK: - Parameters
    @Parameter(title: "Theme", default: .blue)
    var theme: WidgetBackgroundMode
}
