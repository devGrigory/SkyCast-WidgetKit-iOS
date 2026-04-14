//
//  WidgetBackgroundMode.swift
//  skycast-widgetkit
//
//  Created by Grigory G. on 12.03.26.
//

import SwiftUI
import AppIntents

// MARK: - Widget Theme / Configuration

enum WidgetBackgroundMode: String, AppEnum {
    
    // MARK: - Cases
    case blue, dark
    
    // MARK: - Display Representation
    static var typeDisplayRepresentation: TypeDisplayRepresentation = "Background Mode"
    
    static var caseDisplayRepresentations: [WidgetBackgroundMode: DisplayRepresentation] = [
        .blue: "Blue Gradient",
        .dark: "Dark Mode"
    ]
    
    // MARK: - UI Appearance
    var gradient: LinearGradient {
        switch self {
        case .blue:
            return LinearGradient(
                colors: [
                    Color.blue,
                    Color.cyan
                ],
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
            
        case .dark:
            return LinearGradient(
                colors: [
                    Color.black,
                    Color.gray
                ],
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
        }
    }
}
