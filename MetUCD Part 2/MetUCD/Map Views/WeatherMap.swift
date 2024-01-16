//
//  Map.swift
//  MetUCD
//
//  Created by James Clackett on 20/11/2023.
//

import SwiftUI
import MapKit

/// The WeatherMap View contains the MapKit map and its associated actions/controls.
/// Uses a MapReader to recieve coordinates when a user touches the map
/// Observes the MapViewModel and Toggles Environment Objects.
/// Note: There is currently unexpected behaviour due to state changes in this View (see MapViewModel for more).
struct WeatherMap: View {
    @Environment(MapViewModel.self) var mapViewModel
    @Environment(MapViewModel.Toggles.self) var toggles
    
    var body: some View {
        @Bindable var mapViewModel = mapViewModel
        
        // Here lies the variable I am having issues with.
        let currentTemp = mapViewModel.weatherViewModel.currentWeather?.temperatures.current ?? 0
        
        MapReader { reader in
            Map(position: $mapViewModel.mapCenter){
                // Creates a Map Annotation at the selected location
                Annotation("", coordinate: mapViewModel.selectedLocation) {
                    TemperatureIcon(temp: currentTemp)
                }
            }
            // onTap Map, update the viewModel selected location.
            // if search mode is on, turn it off.
            .onTapGesture(perform: { screenCoord in
                withAnimation{
                    if toggles.isSearchMode {
                        toggles.isSearchMode = false
                    } else {
                        let pinLocation = reader.convert(screenCoord, from: .local) ?? MapViewModel.MapDefaults.location
                        mapViewModel.selectedLocation = pinLocation
                    }
                }
            })
            // Confirm and update CLLocation services.
            .onAppear {
                mapViewModel.confirmLocationServicesEnabled { success in
                    if success {
                        mapViewModel.confirmLocationAuthorized()
                    }
                }
            }
//            .mapControls{
//                MapCompass()
//                          I have tried many things to make this move and react to touch, no luck :(
//            }
            .ignoresSafeArea()
        }
    }
        
        
}


/// An Icon to represent Temperature at the selected location.
/// Contains a balloon icon with a temperature inside.
struct TemperatureIcon: View {
    var temp: Int
    
    var body: some View {
        ZStack {
            Image(systemName: "arrowtriangle.down.fill")
                .font(.system(size: 45))
                .foregroundColor(.green)
                .padding(.top, 15)
                .overlay {
                    Image(systemName: "circle.fill")
                        .font(.system(size: 40))
                        .foregroundColor(.green)
                }
            Text("\(temp)°")
                .foregroundColor(.white)
                .font(.system(size: 20))
        }
    }
}
