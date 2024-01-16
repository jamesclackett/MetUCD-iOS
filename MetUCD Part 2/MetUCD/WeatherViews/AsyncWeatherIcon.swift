//
//  AsyncWeatherIcon.swift
//  MetUCD
//
//  Created by James Clackett on 20/11/2023.
//

import SwiftUI

/// An asynchronouus Image that generates its icon from a specified URL.
/// Used to create weather icons based on icon strings received in openWeatherAPIs forecasts.
/// If the Image cannot be found, a default is used in its place.
struct AsyncWeatherIcon: View {
    
    let icon: String
    
    var body: some View {
        AsyncImage(url: URL(string: WeatherModel.APIURLs.imageIcon(icon: icon).urlString)) { phase in
            switch phase {
            
            case .empty:
            ProgressView()
            
            case .success(let image):
                image
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .background(Color(red: 0.9, green: 0.9, blue: 0.9))
                    .clipShape(.rect(cornerRadius: 8))
            
            case .failure:
                DefaultIcon()
            
            default:
                DefaultIcon()
            }
        }
    }
}

/// A default icon to show if AsyncWeatherIcon fails to load an image.
/// Styles the same as AsyncWeatherIcon for consistency. Contains a question mark in place of a weather icon.
struct DefaultIcon: View {
    
    var body: some View {
        Image(systemName: "questionmark")
            .resizable()
            .aspectRatio(contentMode: .fit)
            .background(Color(red: 0.9, green: 0.9, blue: 0.9))
            .clipShape(.rect(cornerRadius: 8))
    }
}


