//
//  PollutionForecastView.swift
//  MetUCD
//
//  Created by James Clackett on 17/11/2023.
//

import SwiftUI
import Charts

/// A view that displays the Air Pollution Index (AQI) forecast,
/// Uses SwiftUI Charts to plot the information on a graph for easy understanding.
/// AQI Levels 1-5 are mapped to human-readable labels.
struct PollutionForecastView: View {
    @Environment(WeatherViewModel.self) var weatherViewModel
    
    var body: some View {
        let list = weatherViewModel.pollutionForecast?.aqiList ?? []
        
        Chart {
            ForEach(list.indices, id: \.self) { index in
                LineMark(
                    x: .value("Date", list[index].0),
                    y: .value("AQI", Double(list[index].1))
                )
            }
        }
        .chartXAxis {
            AxisMarks(position: .bottom) { _ in
                AxisValueLabel()
            }
        }
        .chartYScale(domain: [1, 5])
        .chartYAxis {
            AxisMarks() {
                AxisGridLine()
                let value = Pollution.airQuality(aqi: $0.as(Int.self)!)
                AxisValueLabel {
                    Text("\(value)")
                }
            }
        }
        .frame(height: 200)
    }
}
