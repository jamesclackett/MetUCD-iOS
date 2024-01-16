//
//  MapView.swift
//  MetUCD
//
//  Created by James Clackett on 18/11/2023.
//

import SwiftUI
import MapKit

/// Creates the Weather Map, NavigationBar, and WeatherWidget.
struct MapView : View {
    @Environment(\.horizontalSizeClass) var sizeClass
    
    var body: some View {
        
        ZStack(alignment: .topLeading) {
            WeatherMap()
            VStack (alignment: sizeClass == .compact ? .leading : .center) {
                NavigationBar()
                Spacer()
                HStack {
                    WeatherWidget()
                }
            }
        }
    }
}

struct MapView_Previews: PreviewProvider {
    static var previews: some View {
        MapView()
    }
}
