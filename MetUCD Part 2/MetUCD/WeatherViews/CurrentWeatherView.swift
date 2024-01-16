//
//  CurrentWeatherView.swift
//  MetUCD
//
//  Created by James Clackett on 17/11/2023.
//

import SwiftUI

/// A view that displays current weather information.
struct CurrentWeatherView: View {
    @Environment(MapViewModel.self) var mapViewModel
    
    var body: some View {
        
        let currentWeather = mapViewModel.weatherViewModel.currentWeather
        let temperatures = currentWeather?.temperatures
        let windInfo = currentWeather?.windInfo
        
        VStack(alignment: .leading) {
            
            // Temperatures:
            HStack{
                Image(systemName: "thermometer.medium")
                    .foregroundStyle(.blue)
                Text("\(temperatures?.current ?? 0)°")
                
                Text("(L: \(temperatures?.min ?? 0)° H: \(temperatures?.max ?? 0)°)")
                    .foregroundStyle(.gray)
                
                Image(systemName: "thermometer.variable.and.figure")
                    .foregroundStyle(.blue)
                Text("Feels \(temperatures?.feelsLike ?? 0)°")
            }
            Divider()
            
            // Cloud coverage:
            HStack {
                Image(systemName: "cloud")
                    .foregroundStyle(.blue)
                Text("\(currentWeather?.coverage ?? 0)% coverage")
            }
            Divider()
            
            // Wind Information:
            HStack{
                Image(systemName: "wind")
                    .foregroundStyle(.blue)
                Text(String(format: "%.1f", windInfo?.0 ?? 0) + "km/h. dir: \(windInfo?.1 ?? 0)°")
            }
            Divider()
            
            // Air Information
            HStack{
                Image(systemName: "humidity")
                    .foregroundStyle(.blue)
                Text("\(currentWeather?.humidity ?? 0)%")
                Image(systemName: "barometer")
                    .foregroundStyle(.blue)
                Text("\(currentWeather?.pressure ?? 0) hPA")
            }
            
        }
    }
}
