//
//  WeatherForecastView.swift
//  MetUCD
//
//  Created by James Clackett on 18/11/2023.
//

import SwiftUI

/// A view that displays the weather forecast for the next (up to 5) days.
/// Iterates through a forecast result and creates N DayForecastViews.
struct WeatherForecastView: View {
    @Environment(WeatherViewModel.self) var weatherViewModel
    
    var body: some View {
        
        let forecast = weatherViewModel.weatherForecast?.dayList ?? [DayItem]()
        
        VStack {
            ForEach(forecast.indices, id: \.self) { index in
                DayForecastView(day: forecast[index].name,
                                values: forecast[index].iconArray ,
                                low: forecast[index].tempMin ,
                                high: forecast[index].tempMax)
                Divider()
            }
        }
    }
}

/// A view that represents the overall forecast for a single day.
/// Displays the day name and its lowest/highest temperatures.
/// Displays a list of icons that show the weather for 8, 3hr intervals throughout that day.
struct DayForecastView: View {
    
    let day: String
    let values: [String]
    let low: Double
    let high: Double
    
    var body: some View {
        
        VStack {
            // Day Details (Name, low, high)
            HStack {
                Text(day)
                    .foregroundStyle(.blue)
                    .fontWeight(.medium)
                Spacer()
                Image(systemName: "thermometer.low")
                    .foregroundStyle(.gray)
                Text("\(Int(low))°")
                    .foregroundStyle(.gray)
                Image(systemName: "thermometer.high")
                    .foregroundStyle(.gray)
                Text("\(Int(high))°")
                    .foregroundStyle(.gray)
            }
            .padding(4)
        }
    }
}
