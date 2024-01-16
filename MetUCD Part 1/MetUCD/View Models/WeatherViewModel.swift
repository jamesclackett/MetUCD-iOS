//
//  WeatherViewModel.swift
//  MetUCD
//
//  Created by James Clackett on 14/11/2023.
//

import SwiftUI

/// An Observable View Model that respresents information recieved from the openWeatherAPI.
/// Contains Initialized Weather API Structs, built by the model.
/// These Structs represent the various aspects of the model generated from API results.
/// Provides a mechanism for updated the lcoation for the model.
/// Updates itself using the updateFields func whenever the model is changed.
@Observable class WeatherViewModel {
    private var model: WeatherModel {
        didSet{ updateFields() }
    }

    var geoInfo: GeoInfo?
    var currentWeather: CurrentWeather?
    var pollution: Pollution?
    var weatherForecast: WeatherForecast?
    var pollutionForecast: PollutionForecast?
    
    /// A default initializer that constructs a WeatherViewModel for Dublin, Ireland. 🍺
    init() {
        model = WeatherModel(lat: 53.34, lon: -6.26)
        updateFields()
    }
    
    /// An initializer that constructs a WeatherViewModel for a specidied location.
    /// - Parameters:
    ///   - lat: The latitude
    ///   - lon: The longitude
    init(lat: Double, lon: Double){
        model = WeatherModel(lat: lat, lon: lon)
        updateFields()
    }
    
    /// A function that asynchronously calls the servcies of the model to initialize/update the forecast structs.
    func updateFields() {
        Task {
            do {
                geoInfo = try await model.getGeoInfo()
                currentWeather = try await model.getCurrentWeather()
                pollution = try await model.getPollution()
                weatherForecast = try await model.getWeatherForecast()
                pollutionForecast = try await model.getPollutionForecast()
            } catch {
                print(error)
            }
        }
    }
    
    /// A func that tells the model to update its location with the given coordinates.
    /// - Parameters:
    ///   - lat: The Latitude.
    ///   - lon: The Longitude.
    func newLocation(lat: Double, lon: Double) {
        model.updateLocation(lat: lat, lon: lon)
    }
    
    /// A func that tells the model to update its location with the given location.
    /// - Parameters:
    ///   - locationString: The String location
    func newLocation(locationString: String) {
        Task {
            let location = try await WeatherModel.getLocation(location: locationString)
            if let coords = location.first {
                newLocation(lat: coords.lat, lon: coords.lon)
            }
        }
    }
   
}
