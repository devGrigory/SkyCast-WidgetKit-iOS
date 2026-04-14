//
//  LocationManager.swift
//  skycast-widgetkit
//
//  Created by Grigory G. on 10.03.26.
//

import CoreLocation
import Combine

// MARK: - Location Error
enum LocationError: Error {
    case unauthorized
    case failed
}

// MARK: - Protocol
protocol LocationProviding {
    var locations: AsyncStream<CLLocation> { get }
    func requestPermission()
}

// MARK: - Location Manager
final class LocationManager: NSObject, ObservableObject, LocationProviding {
    
    // MARK: - Properties
    private let manager = CLLocationManager()
    private var continuation: AsyncStream<CLLocation>.Continuation?
    
    @Published var authorizationStatus: CLAuthorizationStatus = .notDetermined
    
    // MARK: - Stream
    lazy var locations: AsyncStream<CLLocation> = {
        AsyncStream { continuation in
            self.continuation = continuation
            manager.delegate = self
            if manager.authorizationStatus == .authorizedWhenInUse {
                manager.startUpdatingLocation()
            }
        }
    }()
    
    // MARK: - Public API
    func requestPermission() {
        manager.delegate = self
        manager.requestWhenInUseAuthorization()
    }
}

// MARK: - CLLocationManagerDelegate
extension LocationManager: CLLocationManagerDelegate {
    
    // MARK: - Authorization Changes
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        authorizationStatus = manager.authorizationStatus
        if manager.authorizationStatus == .authorizedWhenInUse {
            manager.startUpdatingLocation()
        }
    }
    
    // MARK: - Location Updates
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.last else { return }
        continuation?.yield(location)
    }
}
