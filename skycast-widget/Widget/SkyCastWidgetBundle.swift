//
//  SkyCastWidgetBundle.swift
//  skycast-widget
//
//  Created by Grigory G. on 11.03.26.
//

import SwiftUI
import WidgetKit

// MARK: - Widget Bundle Entry Point
@main
struct SkyCastWidgetBundle: WidgetBundle {
    
    // MARK: - Body
    var body: some Widget {
        SkycastWidget()
    }
}
