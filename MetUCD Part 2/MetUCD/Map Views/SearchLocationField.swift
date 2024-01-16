//
//  SearchLocationField.swift
//  MetUCD
//
//  Created by James Clackett on 20/11/2023.
//

import SwiftUI
import MapKit

/// A view to allow users to search for a location using MapKits LocalSearch functionality.
/// Is Visible/Invisible depending on the state of Toggles.isSearchMode
struct SearchLocationField: View {
    @Environment(MapViewModel.self) var mapViewModel
    @Environment(MapViewModel.Toggles.self) var toggles
    @FocusState private var focused: Bool
    @State private var searchText = ""
    @State private var searchedLocation: MapCameraPosition?
    
    var body: some View {
        @Bindable var mapViewModel = mapViewModel
        
        TextField("Search Location", text: $searchText)
            .frame(height: 50)
            .font(.title3)
            .multilineTextAlignment(.center)
            .background(RoundedRectangle(cornerRadius: 20)
                .stroke(Color.gray, lineWidth: 5)
                .background(.ultraThinMaterial))
            .cornerRadius(20)
            .padding(.leading, 20)
            .padding(.trailing, 20)
            .shadow(radius: 10)
            .foregroundColor(.black)
            .autocorrectionDisabled()
            .focused($focused)
            .onLongPressGesture(minimumDuration: 0.0) { focused = true }
            // Autocorrect and long press seem to cause bug: "Error: this application, or a library it
            // uses, has passed an invalid numeric value (NaN, or not-a-number) to CoreGraphics API"
            // https://developer.apple.com/forums/thread/738726
            .onSubmit { moveToSearchLocation() }
    }
    
    /// A function that uses MapKit's LocalSearch to find a location.
    /// Makes a search with a region of .world and result type of .address. This returns towns, cities, and countries.
    /// If the search is successful (there are results), updates the State variable searchedLocation.
    func searchLocation() async {
        let request = MKLocalSearch.Request()
        request.naturalLanguageQuery = searchText
        request.region = MKCoordinateRegion(.world)
        request.resultTypes = MKLocalSearch.ResultType.address

        let results = try? await MKLocalSearch(request: request).start()
        let foundLoc = results?.mapItems ?? []
        
        if !foundLoc.isEmpty {
            let locCoord = foundLoc.first?.placemark.coordinate
            self.searchedLocation = MapCameraPosition.region(MKCoordinateRegion(center: locCoord ?? MapViewModel.MapDefaults.location , span: MapViewModel.MapDefaults.span))
        }
    }
    
    /// A function that updates the mapViewModel to the searched location (if found by MapKit).
    /// Resets the search text and hides the search text field if the search was a success.
    func moveToSearchLocation() {
        Task {
            await searchLocation()
            searchText = ""
            
            withAnimation {
                if let searchedLocation {
                    mapViewModel.selectedLocation = searchedLocation.region?.center ?? MapViewModel.MapDefaults.location
                    toggles.isSearchMode = false
                }
                
            }
        }
    }
}
