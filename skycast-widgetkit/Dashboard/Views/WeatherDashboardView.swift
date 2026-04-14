//
//  WeatherDashboardView.swift
//  skycast-widgetkit
//
//  Created by Grigory G. on 10.03.26.
//

import SwiftUI
import WidgetKit

// MARK: - Weather Dashboard View
struct WeatherDashboardView: View {
    
    // MARK: - Properties
    @StateObject private var viewModel: WeatherViewModel
    
    // MARK: - Initialization
    init(viewModel: WeatherViewModel) {
        _viewModel = StateObject(wrappedValue: viewModel)
    }
    
    // MARK: - Body
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: Constants.Layout.mainSpacing) {
                headerSection
                
                contentSection
            }
            .padding()
        }
        .scrollIndicators(.hidden, axes: .vertical)
        .onAppear {
            viewModel.start()
        }
    }
}

// MARK: - View Components
private extension WeatherDashboardView {
    
    var headerSection: some View {
        VStack(spacing: Constants.Layout.headerSpacing) {
            Text(Constants.Text.title)
                .font(.title)
                .bold()
                .frame(maxWidth: .infinity, alignment: .center)
            
            Text(Constants.Text.subtitle)
                .font(.subheadline)
                .foregroundColor(.secondary)
                .frame(maxWidth: .infinity, alignment: .center)
        }
        .padding(.top, Constants.Layout.topPadding)
    }
    
    var contentSection: some View {
        Group {
            if viewModel.isLoading {
                loadingView
            } else if let current = viewModel.current {
                weatherList(current: current, featured: viewModel.featured)
            } else if let error = viewModel.error {
                errorView(message: error)
            } else {
                idleView
            }
        }
    }
    
    var idleView: some View {
        ContentUnavailableView(Constants.Text.locating, systemImage: Constants.Text.locationIcon)
    }
    
    var loadingView: some View {
        HStack {
            Spacer()
            ProgressView()
                .tint(.white)
                .frame(width: Constants.Layout.loadingBoxSize, height: Constants.Layout.loadingBoxSize)
                .background(Color.black.opacity(0.8))
                .clipShape(RoundedRectangle(cornerRadius: Constants.Layout.cornerRadius))
            Spacer()
        }
        .padding(.vertical, Constants.Layout.verticalPadding)
    }
    
    func weatherList(current: CityWeatherViewModel, featured: [CityWeatherViewModel]) -> some View {
        VStack(spacing: Constants.Layout.mainSpacing) {
            WeatherCardView(model: current)
            
            ForEach(featured, id: \.city) { cityModel in
                WeatherCardView(model: cityModel)
            }
        }
    }
    
    func errorView(message: String) -> some View {
        VStack {
            Image(systemName: Constants.Text.errorIcon)
            Text(message)
        }
        .foregroundColor(.red)
        .frame(maxWidth: .infinity)
    }
}
