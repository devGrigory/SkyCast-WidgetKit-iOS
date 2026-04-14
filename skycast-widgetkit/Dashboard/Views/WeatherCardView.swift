//
//  WeatherCardView.swift
//  skycast-widgetkit
//
//  Created by Grigory G. on 10.03.26.
//

import SwiftUI
import Combine

// MARK: - Weather Card View
struct WeatherCardView: View {
    
    // MARK: - Properties
    let model: CityWeatherViewModel?
    
    // MARK: - State
    @State private var currentDate = Date()
    @State private var timerTask: Task<Void, Never>?
    
    // MARK: - Body
    var body: some View {
        ZStack {
            WeatherGradientView(condition: model?.condition ?? .unknown)
            WeatherOverlayGradientView()
            content
        }
        .onAppear {
            startPreciseTimer()
        }
        .onDisappear {
            stopTimer()
        }
        .frame(maxWidth: .infinity, minHeight: Constants.Card.minHeight)
        .clipShape(RoundedRectangle(cornerRadius: Constants.Card.cornerRadius))
    }
}

//MARK: - Timer Logic
private extension WeatherCardView {
    
    func startPreciseTimer() {
        stopTimer()
        
        timerTask = Task {
            let now = Date()
            let calendar = Calendar.current
            
            guard let nextMinute = calendar.nextDate(
                after: now,
                matching: DateComponents(second: 0),
                matchingPolicy: .nextTime
            ) else { return }
            
            let delay = nextMinute.timeIntervalSince(now)
            try? await Task.sleep(nanoseconds: UInt64(delay * 1_000_000_000))
            
            while !Task.isCancelled {
                await MainActor.run {
                    self.currentDate = Date()
                }
                
                try? await Task.sleep(nanoseconds: 60 * 1_000_000_000)
            }
        }
    }
    
    func stopTimer() {
        timerTask?.cancel()
        timerTask = nil
    }
}

// MARK: - Content View
private extension WeatherCardView {
    
    var content: some View {
        VStack(alignment: .leading, spacing: 0) {
            
            locationText
            
            if model?.isCurrentLocation == true {
                currentLocationLabel
            }
            
            weatherInfoRow
            
            timeText
        }
        .padding()
    }
}

// MARK: - View Components
private extension WeatherCardView {
    
    var locationText: some View {
        Text("\(model?.country ?? ""), \(model?.city ?? "")")
            .font(.headline)
            .foregroundStyle(.white)
    }
    
    var currentLocationLabel: some View {
        Text(Constants.Card.currentLocationLabel)
            .font(.caption)
            .foregroundStyle(.white.opacity(0.85))
    }
    
    var weatherInfoRow: some View {
        HStack {
            Image(systemName:
                    model.map { icon(for: $0) } ?? "cloud.sun.fill"
            )
            .font(.system(size: Constants.Card.iconSize))
            .foregroundStyle(.white)
            
            Spacer()
            
            Text(model?.temperatureText ?? "--°C")
                .font(.system(size: Constants.Card.tempFontSize, weight: .bold))
                .foregroundStyle(.white)
        }
        .padding(.vertical, Constants.Card.innerPadding)
    }
    
    /// Update the timeText to use the moving 'currentDate'
    var timeText: some View {
        TimelineView(.periodic(from: .now, by: 60)) { context in
            Text(
                timeString(
                    from: context.date,
                    timeZone: model?.timeZone ?? .current
                )
            )
            .foregroundStyle(.white.opacity(0.9))
        }
    }
}

// MARK: - Helpers
private extension WeatherCardView {
    
    // MARK: - Formatting
    func timeString(from date: Date, timeZone: TimeZone) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = Constants.Card.timeFormat
        formatter.timeZone = timeZone
        formatter.locale = Locale(identifier: Constants.Card.localeIdentifier)
        return formatter.string(from: date)
    }
    
    func icon(for model: CityWeatherViewModel) -> String {
        WeatherIconMapper.icon(
            for: model.condition,
            date: model.date,
            timeZone: model.timeZone
        )
    }
}
