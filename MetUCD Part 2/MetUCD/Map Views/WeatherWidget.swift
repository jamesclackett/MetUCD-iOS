//
//  WeatherWidget.swift
//  MetUCD
//
//  Created by James Clackett on 20/11/2023.
//

import SwiftUI

/// A view to contain on overview of weather forecast information at the selected location.
/// Observes the MapViewModel Environment Object and updates its fields accoriding to state.
/// Uses a State variable sheetShowing  to control the showing/hiding of a sheet view
/// When the user taps the Widget, WeatherView is opened to show more detailed weather information to the user.
struct WeatherWidget: View {
    @Environment(MapViewModel.self) var mapViewModel
    @Environment(MapViewModel.Toggles.self) var toggles // isSearch turned off when user taps the Widget
    @Environment(\.horizontalSizeClass) var sizeClass
    @State private var sheetShowing = false
    
    var body: some View {
        let temp = mapViewModel.weatherViewModel.currentWeather?.temperatures
        let description = mapViewModel.weatherViewModel.currentWeather?.description ?? "Unknown"
        let locationName = mapViewModel.weatherViewModel.geoInfo?.name ?? "Unknown"
        
        if !toggles.isSearchMode {
            ZStack {
                RoundedRectangle(cornerRadius: 20)
                    .fill(.ultraThinMaterial)
                    .stroke(.gray, lineWidth: 3)
                    .frame(height: 200)
                    .frame(width: sizeClass == .compact ? 300: nil)
                    .padding(.trailing, 40)
                    .padding(.leading, 40)
                    .padding(.bottom, 40)
                VStack (alignment: .center) {
                    Text("\(locationName)")
                        .font(.title)
                    HStack {
                        Image(systemName: "thermometer")
                            .font(.system(size: 50))
                            .fontWeight(.thin)
                            .foregroundStyle(.gray)
                        Text("\(temp?.current ?? 0)°")
                            .font(.system(size: 70))
                            .fontWeight(.thin)
                            .foregroundStyle(.gray)
                    }
                    Text("\(description.capitalized)")
                        .font(.system(size: 20))
                        .padding(.bottom, 5)
                    Text("(L: \(temp?.min ?? 0) H: \(temp?.max ?? 0))")
                        .font(.system(size: 18))
                        .foregroundStyle(.gray)
                }
                .padding(.trailing, 40)
                .padding(.leading, 40)
                .padding(.bottom, 40)
            }
            // Open sheet WeatherView
            .onTapGesture {
                sheetShowing = true
                toggles.isSearchMode = false
            }
            .sheet(isPresented: $sheetShowing, content: {
                WeatherView()
            })
        }
    }

}
