//
//  NavigationBar.swift
//  MetUCD
//
//  Created by James Clackett on 20/11/2023.
//

import SwiftUI
import MapKit

/// A view that contains the 3 core controls for the Map
/// - UserLocationButton: when pressed, centers map at user's current location
/// - SearchLocationField: allows user to search for a location
/// - SearchLocationButton: shows the SearchLocationField
///
/// SearchLocationField's visibility is controled by a state variable
struct NavigationBar: View {
    @Environment(MapViewModel.Toggles.self) var toggles
    
    var body: some View {
        
        HStack {
            if !toggles.isSearchMode {
                UserLocationButton()
            }
            Spacer()
            if toggles.isSearchMode {
                SearchLocationField()
            }
            if !toggles.isSearchMode {
               SearchLocationButton()
            }
        }
        .padding(.top, 20)
    }
}

/// A Button that allows the user to center the Map on their current location.
/// Updates the view model's selected location, animates the location change.
/// The Icon consists of a simple overlay of two Image views.
struct UserLocationButton: View {
    @Environment(MapViewModel.self) var mapViewModel
    
    var body: some View {
        @Bindable var mapViewModel = mapViewModel
        
        Button(action: {
            withAnimation{
                mapViewModel.selectedLocation = mapViewModel.userLocation.region?.center ?? MapViewModel.MapDefaults.location
            }
        },
               label: {
            Image(systemName: "location.circle")
                .font(.system(size: 40))
                .foregroundColor(Color.gray) // Stroke color
                .overlay(
                    Image(systemName: "location.circle.fill")
                        .font(.system(size: 35))
                        .foregroundColor(Color(red: 0.9, green: 0.9, blue: 0.9))
                )
        })
        .padding(.leading, 30)
        
    }
}

/// A Button that makes the SearchLocationField visible
/// Updates the Environment Object variable Toggle.isSearchMode
/// The Icon consists of a simple overlay of two Image views.
struct SearchLocationButton: View {
    @Environment(MapViewModel.Toggles.self) var toggles
    
    var body: some View {
        
        Button(action: {
            withAnimation{
                toggles.isSearchMode = true
            }
        },
            label: {
            Image(systemName: "circle.fill")
                .font(.system(size: 40))
                .foregroundColor(Color.gray) // Stroke color
                .overlay(
                    Image(systemName: "magnifyingglass.circle.fill")
                        .font(.system(size: 35))
                        .foregroundColor(Color(red: 0.9, green: 0.9, blue: 0.9))
                )
        })
        .padding(.trailing, 30)
    }
}
