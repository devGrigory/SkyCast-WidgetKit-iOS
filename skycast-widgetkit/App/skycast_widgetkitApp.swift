//
//  skycast_widgetkitApp.swift
//  skycast-widgetkit
//
//  Created by Grigory G. on 10.03.26.
//

import SwiftUI

@main
struct skycast_widgetkitApp: App {
    
    // MARK: - Dependencies
    private let locationManager = LocationManager()
    private let weatherService = WeatherService()
    private let pollingService = WeatherPollingService()
    
    private var repository: WeatherRepository {
        WeatherRepository(service: weatherService)
    }
    
    private var viewModel: WeatherViewModel {
        WeatherViewModel(
            repository: repository,
            locationManager: locationManager,
            pollingService: pollingService
        )
    }
    
    // MARK: - Scene
    var body: some Scene {
        WindowGroup {
            WeatherDashboardView(viewModel: viewModel)
        }
    }
}
