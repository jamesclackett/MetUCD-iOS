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
    
    var body: some Scene {
        WindowGroup {
            WeatherView()
                .environment(WeatherViewModel())
        }
    }

}
