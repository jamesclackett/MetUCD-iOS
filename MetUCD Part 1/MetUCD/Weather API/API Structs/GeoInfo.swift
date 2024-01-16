//
//  GeoInfo.swift
//  MetUCD
//
//  Created by James Clackett on 15/11/2023.
//

import Foundation

/// A Codable Struct that represents a GeoInfo result from openWeatherAPI.
/// Specifically, represents infomation from the Current Weather API.
/// GeoInfo is a representation of the location for a forecast.
/// Provides getters to access user-friendly results.
struct GeoInfo: Codable {
    
    struct Coord: Codable {
        let lat: Double
        let lon: Double
    }
    
    struct Sys: Codable {
        let sunrise: Int
        let sunset: Int
    }
    
    private let coordinates: Coord
    private let sunRiseAndSet: Sys
    private let datetime: Int
    private let timezone: Int
    
    enum CodingKeys: String, CodingKey {
        case name = "name"
        case coordinates = "coord"
        case sunRiseAndSet = "sys"
        case datetime = "dt"
        case timezone = "timezone"
    }
    
    //
    // FOR USERS:
    //
    
    /// The name of the specified location
    let name: String
    
    /// The DMS Latitude
    var latitude: String {
        return WeatherModel.coordinatesToDMS(latitude: coordinates.lat, longitude: coordinates.lon).latitude
    }
    
    /// The DMS Longitude
    var longitude: String {
        return WeatherModel.coordinatesToDMS(latitude: coordinates.lat, longitude: coordinates.lon).longitude
    }
    
    /// A String tuple of selected and local sunrises
    var sunrise: (String, String) {
        let sunriseA = Date(timeIntervalSince1970: TimeInterval(sunRiseAndSet.sunrise))
        let sunriseB = Date(timeIntervalSince1970: TimeInterval(sunRiseAndSet.sunrise) - Double(timezone))
        return (WeatherModel.formatDate(date: sunriseA, format: "HH:mm"), WeatherModel.formatDate(date: sunriseB, format: "HH:mm") )
    }
    
    /// A String tuple of selected and local sunsets
    var sunset: (String, String) {
        let sunsetA = Date(timeIntervalSince1970: TimeInterval(sunRiseAndSet.sunset))
        let sunsetB = Date(timeIntervalSince1970: TimeInterval(sunRiseAndSet.sunset) - Double(timezone))
        return (WeatherModel.formatDate(date: sunsetA, format: "HH:mm"), WeatherModel.formatDate(date: sunsetB, format: "HH:mm"))
    }
    
    /// A formatted String  time difference between the specified locations' timezine and GMT
    var timeDifference: String {
        let hours = timezone / 3600
        let sign = (hours >= 0) ? "+" : "-"
            
        return "\(sign)\(abs(hours))H"
    }
    

}
