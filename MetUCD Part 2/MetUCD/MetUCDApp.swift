//
//  MetUCDApp.swift
//  MetUCD
//
//  Created by James Clackett on 14/11/2023.
//

import SwiftUI
import CoreLocation

@main
struct MetUCDApp: App {
    private var mapViewModel = MapViewModel()
    private var toggles = MapViewModel.Toggles()
    
    var body: some Scene {
        WindowGroup {
            MapView()
                .environment(mapViewModel)
                .environment(toggles)
        }
    }

}
