//
//  WeatherModel.swift
//  MetUCD
//
//  Created by James Clackett on 14/11/2023.
//

import Foundation


/// A model that acts as an interface with openWeatherAPI.
/// Manages, validates, and serves API data.
/// Holds a latitude and longitude state. Makes dynamic requests to openWeatherAPI based on these.
struct WeatherModel: Codable {
    
    var latitude: Double
    var longitude: Double
    
    /// Initializes the model with a specified latitude and longitude.
    init(lat: Double, lon: Double)  {
        self.latitude = lat
        self.longitude = lon
    }
    
    /// An asynchronous function that returns a GeoInfo Object
    /// Queries openWeatherAPI with the models static getResult function.
    /// - Returns: A GeoInfo Object
    func getGeoInfo() async throws -> GeoInfo {
        let url = APIURLs.weatherCurrent(lat: latitude, lon: longitude).urlString
        return try await WeatherModel.getResult(url: url)
    }
    
    /// An asynchronous function that returns a CurrentWeather Object
    /// Queries openWeatherAPI with the models static getResult function.
    /// - Returns: A CurrentWeather Object
    func getCurrentWeather() async throws -> CurrentWeather {
        let url = APIURLs.weatherCurrent(lat: latitude, lon: longitude).urlString
        return try await WeatherModel.getResult(url: url)
    }
    
    /// An asynchronous function that returns a Pollution Object
    /// Queries openWeatherAPI with the models static getResult function.
    /// - Returns: A Pollution Object
    func getPollution() async throws -> Pollution {
        let url = APIURLs.pollutionCurrent(lat: latitude, lon: longitude).urlString
        return try await WeatherModel.getResult(url: url)
    }
    
    /// An asynchronous function that returns a WeatherForecast Object
    /// Queries openWeatherAPI with the models static getResult function.
    /// - Returns: A WeatherForecast Object
    func getWeatherForecast() async throws -> WeatherForecast {
        let url = APIURLs.weatherForecast(lat: latitude, lon: longitude).urlString
        return try await WeatherModel.getResult(url: url)
    }
    
    /// An asynchronous function that returns a PollutionForecast Object
    /// Queries openWeatherAPI with the models static getResult function.
    /// - Returns: A PollutionForecast Object
    func getPollutionForecast() async throws -> PollutionForecast {
        let url = APIURLs.pollutionForecast(lat: latitude, lon: longitude).urlString
        return try await WeatherModel.getResult(url: url)
    }
    
    /// A function that updates the
    /// Queries openWeatherAPI with the models static getResult function.
    /// - Parameters:
    ///   - lat: The new latitude.
    ///   - lon: The new longitude
    mutating func updateLocation(lat: Double, lon: Double) {
        self.latitude = lat
        self.longitude = lon
    }
}

extension WeatherModel {
    
    // I found coordinatesToDMS from online sources
    // It converts latitude and longitude to string DMS format.
    /// A function that converts coordinates from Decimal Degrees (DD)  to Degrees-Minutes-Seconds (DMS).
    ///  - Parameters:
    ///    - latitude: The decimal latitude to convert.
    ///    - longitude: The decimal longitude to convert
    ///  - Returns: A String tuple representing the DMS coordinates
    static func coordinatesToDMS(latitude: Double, longitude: Double) -> (latitude: String, longitude: String) {
        let latDegrees = abs(Int(latitude))
        let latMinutes = abs(Int((latitude * 3600).truncatingRemainder(dividingBy: 3600) / 60))
        let latSeconds = abs(Int((latitude * 3600).truncatingRemainder(dividingBy: 3600).truncatingRemainder(dividingBy: 60)))
        
        let lonDegrees = abs(Int(longitude))
        let lonMinutes = abs(Int((longitude * 3600).truncatingRemainder(dividingBy: 3600) / 60))
        let lonSeconds = abs(Int((longitude * 3600).truncatingRemainder(dividingBy: 3600).truncatingRemainder(dividingBy: 60)))
        
        return (String(format:"%d° %d' %d\" %@", latDegrees, latMinutes, latSeconds, latitude >= 0 ? "N" : "S"),
                String(format:"%d° %d' %d\" %@", lonDegrees, lonMinutes, lonSeconds, longitude >= 0 ? "E" : "W"))
    }
    
    /// A function that formats a Date Object using a specified format String
    ///  - Parameters:
    ///    - date: The Date Object to be formatted.
    ///    - format: The format that the DateFormatter should use.
    static func formatDate(date: Date, format: String) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = format
        return formatter.string(from: date)
    }
}
