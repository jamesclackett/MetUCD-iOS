//
//  GeoInfoView.swift
//  MetUCD
//
//  Created by James Clackett on 17/11/2023.
//

import SwiftUI

/// A view that displays  location information for the current forecast.
/// Contains primarily  geographical information such as coordinates, time difference, sunrise/set etc.
struct GeoInfoView : View {
    @Environment(WeatherViewModel.self) var weatherViewModel
    
    var body: some View {
        
        let geoInfo = weatherViewModel.geoInfo
        let sunrise = geoInfo?.sunrise
        let sunset = geoInfo?.sunset
        let timeDiff = geoInfo?.timeDifference
        
        VStack(alignment: .leading) {
            
            // Coordinates:
            HStack{
                Image(systemName: "location")
                    .foregroundStyle(.blue)
                Text("\(geoInfo?.latitude ?? "0"),")
                Text("\(geoInfo?.longitude ?? "0")")
            }
            Divider()
            
            // Sunset and Sunrise (local and selected)
            HStack{
                Image(systemName: "sunrise").foregroundStyle(.blue)
                Text(sunrise?.0 ?? "0:00")
                Text("(\(sunrise?.1 ?? "0:00"))")
                    .foregroundStyle(.gray)
                
                Image(systemName: "sunset").foregroundStyle(.blue)
                Text(sunset?.0 ?? "0:00")
                Text("(\(sunset?.1 ?? "0:00"))")
                    .foregroundStyle(.gray)
            }
            Divider()
            
            // Time Difference between local and selected
            HStack {
                Image(systemName: "clock.arrow.2.circlepath")
                    .foregroundStyle(.blue)
                Text(timeDiff ?? "0H")
            }
        }
    }
}

