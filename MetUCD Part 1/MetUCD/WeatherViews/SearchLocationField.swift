//
//  SearchLocationField.swift
//  MetUCD
//
//  Created by James Clackett on 20/11/2023.
//

import SwiftUI

/// A view that allows the user to search for a location
/// Uses openWeatherAPIs GeoCoder
/// Updates the binded variable forecastDisplayed to ensure forecast is aded to  WeatherView List.
struct SearchLocationField: View {
    @Environment(WeatherViewModel.self) var weatherViewModel
    @State private var userInput: String = ""
    @Binding var forecastDisplayed: Bool
    @FocusState private var focused: Bool
    
    var body: some View {
        
        TextField("Enter location e.g. Dublin, IE", text: $userInput)
            .autocorrectionDisabled()
            .focused($focused)
            .onLongPressGesture(minimumDuration: 0.0) { focused = true }
            // Autocorrect and long press seem to cause bug: "Error: this application, or a library it
            // uses, has passed an invalid numeric value (NaN, or not-a-number) to CoreGraphics API"
            // https://developer.apple.com/forums/thread/738726
            .onSubmit {
                withAnimation{
                    if !userInput.isEmpty {
                        weatherViewModel.newLocation(locationString: userInput)
                        forecastDisplayed = true
                    }
                }
            }
    }
}
