//
//  MapViewModel.Extension.swift
//  MetUCD
//
//  Created by James Clackett on 20/11/2023.
//

import SwiftUI
import MapKit

extension MapViewModel {
    
    /// Contains Map Defaults to be used during initialization and in the event of API/Location error
    enum MapDefaults {
        static let location = CLLocationCoordinate2D(latitude: 53.3, longitude: -6.284)
        static let span = MKCoordinateSpan(latitudeDelta: 0.5, longitudeDelta: 0.5)
        static let region = MKCoordinateRegion(center: MapDefaults.location, span: MapDefaults.span)
    }
    
    /// A class to represent Map Toggles
    /// Currently contains the isSearchMode toggle only but can be easily added to.
    @Observable class Toggles {
        var isSearchMode = false
    }
}
