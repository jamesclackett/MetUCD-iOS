//
//  PollutionView.swift
//  MetUCD
//
//  Created by James Clackett on 17/11/2023.
//

import SwiftUI

/// A view that displays the various pollution metrics at the current location.
struct PollutionView: View {
    @Environment(MapViewModel.self) var mapViewModel
    
    var body: some View {
        
        let pollution = mapViewModel.weatherViewModel.pollution
        let componentsMap = pollution?.components ?? [:]
        
        // A vertical stack of pollution metrics (2 metrics at each level)
        ForEach(0..<componentsMap.count / 2, id: \.self) { index in
            VStack() {
                
                HStack() {
                    Text("\(Array(componentsMap.keys)[index * 2].uppercased()): ")
                        .foregroundColor(.blue)
                    Text("\(String(format: "%.1f", Array(componentsMap.values)[index * 2]))")
                    Spacer()
                    Text("\(Array(componentsMap.keys)[index * 2 + 1].uppercased()): ")
                        .foregroundColor(.blue)
                    Text("\(String(format: "%.1f", Array(componentsMap.values)[index * 2 + 1]))")
                }
            }
            
        }
        // Footer
        Text("(units: µg/m3)")
            .font(.system(size: 15))
            .foregroundColor(.gray)
    }
}
