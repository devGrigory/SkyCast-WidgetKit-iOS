//
//  WeatherViewModel.swift
//  skycast-widgetkit
//
//  Created by Grigory G. on 10.03.26.
//

import Combine
import CoreLocation
import WidgetKit

@MainActor
final class WeatherViewModel: ObservableObject {
    
    // MARK: - View State
    enum ViewState {
        case idle
        case loading
        case success(current: CityWeatherViewModel, featured: [CityWeatherViewModel])
        case error(String)
    }
    
    // MARK: - Published State
    @Published private(set) var current: CityWeatherViewModel?
    @Published private(set) var featured: [CityWeatherViewModel] = []
    @Published private(set) var isLoading: Bool = false
    @Published private(set) var error: String?
    
    // MARK: - Dependencies
    private let repository: WeatherRepository
    private let locationManager: LocationProviding
    private let pollingService: WeatherPolling
    
    // MARK: - Internal State
    private var observationTask: Task<Void, Never>?
    private var cancellables = Set<AnyCancellable>()
    private var lastLocation: CLLocation?
    
    // MARK: - Initialization
    init(
        repository: WeatherRepository,
        locationManager: LocationProviding,
        pollingService: WeatherPolling
    ) {
        self.repository = repository
        self.locationManager = locationManager
        self.pollingService = pollingService
    }
    
    deinit {
        let service = pollingService
        Task { @MainActor in
            service.stop()
        }
    }
    
    // MARK: - Public API
    func start() {
        isLoading = true
        startLocationObservation()
    }
    
    // MARK: - Location Observation
    func startLocationObservation() {
        let status = CLLocationManager().authorizationStatus
        
        print("📍 Authorization status:", status.rawValue)
        
        if status == .notDetermined {
            locationManager.requestPermission()
        }
        
        observationTask = Task {
            for await location in locationManager.locations {
                self.lastLocation = location
                
                await refreshWeather(for: location)
                
                startPolling()
            }
        }
    }
    
    // MARK: - Weather Orchestration (Initial Load)
    private func refreshWeather(for location: CLLocation) async {
        print("🌤 Initial load")
        
        isLoading = true
        
        do {
            async let localGeo = resolveLocationName(from: location)
            async let featuredData = repository.fetchFeaturedCities()
            async let dto = repository.fetchWeather(
                lat: location.coordinate.latitude,
                lon: location.coordinate.longitude
            )
            
            let (geo, featuredModels, weatherDTO) = try await (localGeo, featuredData, dto)
            
            // MARK: - Current model
            let currentModel = CityWeatherViewModel(
                city: geo.city,
                country: geo.country,
                temperature: weatherDTO.temperature,
                condition: WeatherCondition(weatherDTO.condition),
                date: Date(),
                timeZone: .current,
                isCurrentLocation: true,
                lat: location.coordinate.latitude,
                lon: location.coordinate.longitude
            )
            
            self.current = currentModel
            self.featured = featuredModels
            print("✅ Initial data loaded")
            
            // MARK: - Widget Sync
            /// refresh widget UI
            guard let current = self.current else { return }
            
            WidgetSyncService.shared.pushUpdate(cities: toWidgetModel(current: current, featured: self.featured))
        } catch {
            self.error = error.localizedDescription
        }
        
        isLoading = false
    }
    
    // MARK: - Widget Mapping
    private func toWidgetModel(
        current: CityWeatherViewModel,
        featured: [CityWeatherViewModel]
    ) -> [CityWeatherEntity] {
        
        let current = CityWeatherEntity(
            name: current.city,
            temperature: current.temperature,
            condition: current.condition,
            date: current.date,
            timeZoneIdentifier: current.timeZone.identifier,
            country: current.country,
            lat: current.lat,
            lon: current.lon,
            isCurrentLocation: true
        )
        
        let featured = featured.map {
            CityWeatherEntity(
                name: $0.city,
                temperature: $0.temperature,
                condition: $0.condition,
                date: $0.date,
                timeZoneIdentifier: $0.timeZone.identifier,
                country: "",
                lat: 0,
                lon: 0,
                isCurrentLocation: false
            )
        }
        
        return [current] + featured
    }
    
    // MARK: - Location Name Resolver
    private func resolveLocationName(from location: CLLocation) async -> (city: String, country: String) {
        let geocoder = CLGeocoder()
        let placemarks = try? await geocoder.reverseGeocodeLocation(location)
        let place = placemarks?.first
        
        let city = place?.locality ?? Constants.ViewModel.defaultCity
        let country = place?.country ?? Constants.ViewModel.defaultCountry
        return (city, country)
    }
    
    // MARK: - Polling
    private func startPolling() {
        pollingService.start(interval: 60) { [weak self] in
            guard let self else { return }
            Task {
                await self.updateWeatherSilently()
            }
        }
    }
    
    // MARK: - Silent Updates
    private func updateWeatherSilently() async {
        guard let location = lastLocation else { return }
        
        print("🔄 Silent update started")
        
        do {
            let dto = try await repository.fetchWeather(
                lat: location.coordinate.latitude,
                lon: location.coordinate.longitude
            )
            
            /// Update current WITHOUT replacing object
            if let current = self.current {
                self.current = CityWeatherViewModel(
                    city: current.city,
                    country: current.country,
                    temperature: dto.temperature,
                    condition: WeatherCondition(dto.condition),
                    date: Date(),
                    timeZone: current.timeZone,
                    isCurrentLocation: current.isCurrentLocation,
                    lat: current.lat,
                    lon: current.lon
                )
            }
            
            /// Update featured WITHOUT replacing array
            let updatedFeatured = await withTaskGroup(of: (Int, CityWeatherViewModel?).self) { group in
                for (index, city) in featured.enumerated() {
                    group.addTask { [weak self] in
                        guard let self else { return (index, nil) }
                        let dto = try? await self.repository.fetchWeather(
                            lat: city.lat,
                            lon: city.lon
                        )
                        
                        guard let dto else { return (index, nil) }
                        
                        let model = await CityWeatherViewModel(
                            city: city.city,
                            country: city.country,
                            temperature: dto.temperature,
                            condition: WeatherCondition(dto.condition),
                            date: Date(),
                            timeZone: city.timeZone,
                            isCurrentLocation: false,
                            lat: city.lat,
                            lon: city.lon
                        )
                        
                        return (index, model)
                    }
                }
                
                var result: [Int: CityWeatherViewModel] = [:]
                
                for await (index, model) in group {
                    if let model { result[index] = model }
                }
                
                return result.sorted { $0.key < $1.key }.map { $0.value }
            }
            self.featured = updatedFeatured
            print("✅ Silent update applied")
            
        } catch {
            print("❌ Silent update failed:", error)
        }
    }
}
