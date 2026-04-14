//
//  WeatherPollingService.swift
//  skycast-widgetkit
//
//  Created by Grigory G. on 14.03.26.
//

import Combine
import SwiftUI

// MARK: - Weather Polling Protocol
protocol WeatherPolling {
    func start(interval: TimeInterval, action: @escaping () -> Void)
    func stop()
}

// MARK: - Weather Polling Service
final class WeatherPollingService: WeatherPolling {
    
    // MARK: - Properties
    private var task: Task<Void, Never>?
    
    // MARK: - Public API
    func start(interval: TimeInterval, action: @escaping () -> Void) {
        stop()
        
        task = Task {
            while !Task.isCancelled {
                action()
                try? await Task.sleep(
                    nanoseconds: UInt64(interval * 1_000_000_000)
                )
            }
        }
    }
    
    func stop() {
        task?.cancel()
        task = nil
    }
}
