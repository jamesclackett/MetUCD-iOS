//
//  ContentView.swift
//  MetUCD
//
//  Created by James Clackett on 14/11/2023.
//

import SwiftUI

/// A view that displays weather forecast results to the user.
/// Contains a scrollable list of Weather Views created from the view models weather structs.
/// State var forecastDisplayed used to control showing/hiding of forecast
struct WeatherView: View {
    @Environment(WeatherViewModel.self) var weatherViewModel
    @State private var forecastDisplayed = false

    var body: some View {
        
        // Dynamic Headers:
        let weatherDesc = weatherViewModel.currentWeather?.description ?? ""
        let airQuality = Pollution.airQuality(aqi: weatherViewModel.pollution?.aqi ?? 0)
        
        
        List {
            Section(header: Text("SEARCH").foregroundColor(.blue)) {
                SearchLocationField(forecastDisplayed: $forecastDisplayed)
            }
                    
            if forecastDisplayed {
                
                Section(header: Text("GEO INFO")) {
                    GeoInfoView()
                }
                
                Section(header: Text("WEATHER: \(weatherDesc)")) {
                    CurrentWeatherView()
                }
                
                Section(header: Text("FORECAST:")) {
                    WeatherForecastView()
                }

                Section(header: Text("AIR QUALITY: \(airQuality)")) {
                    PollutionView()
                }
                
                Section(header: Text("AIR POLLUTION INDEX FORECAST")) {
                    PollutionForecastView()
                }
            }
        }
        .listStyle(DefaultListStyle())
            
    }
        
}

struct MetView_Previews: PreviewProvider {
    static var previews: some View {
        WeatherView()
    }
}





