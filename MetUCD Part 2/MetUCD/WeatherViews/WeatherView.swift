//
//  ContentView.swift
//  MetUCD
//
//  Created by James Clackett on 14/11/2023.
//

import SwiftUI

/// A view that displays weather forecast results to the user.
/// Contains a scrollable list of Weather Views created from the view models weather structs.
struct WeatherView: View {
    @Environment(MapViewModel.self) var mapViewModel

    var body: some View {
        
        // Dynamic Headers:
        let weatherDesc = mapViewModel.weatherViewModel.currentWeather?.description ?? ""
        let airQuality = Pollution.airQuality(aqi: mapViewModel.weatherViewModel.pollution?.aqi ?? 0)
        
        List {
          
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
        .listStyle(DefaultListStyle())
            
    }
        
}

struct MetView_Previews: PreviewProvider {
    static var previews: some View {
        WeatherView()
    }
}





