//
//  CurrentWeather.swift
//  MetUCD
//
//  Created by James Clackett on 15/11/2023.
//

import Foundation

/// A Codable Struct that represents a CurrentWeather result from openWeatherAPI.
/// Specifically, represents infomation from the Current Weather API.
/// CurrentWeather is a representation of the current weather forecast at a specified location.
/// Provides getters to access user-friendly results.
struct CurrentWeather: Codable {
    
    struct Weather: Codable {
        let description: String
    }
    
    struct Main: Codable {
        let temp: Double
        let temp_min: Double
        let temp_max: Double
        let feels_like: Double
        let humidity: Int
        let pressure: Int
    }
    
    struct Wind: Codable {
        let speed: Double
        let deg: Int
    }
    
    struct Clouds: Codable {
        let all: Int
    }
    
    struct TemperatureGroup {
        let current: Int
        let feelsLike: Int
        let min: Int
        let max: Int
    }
    
    private let weatherDescription: [Weather]
    private let weatherInfo: Main
    private let wind: Wind
    private let cloudCoverage: Clouds
    
    enum CodingKeys: String, CodingKey {
        case weatherDescription = "weather"
        case weatherInfo = "main"
        case wind = "wind"
        case cloudCoverage = "clouds"
    }
    
    //
    // FOR USERS:
    //
    
    /// An Object to represent the four different temperatures in a forecast.
    var temperatures: TemperatureGroup {
        let current = Int(weatherInfo.temp)
        let min = Int(weatherInfo.temp_min)
        let max = Int(weatherInfo.temp_max)
        let feels = Int(weatherInfo.feels_like)
        return TemperatureGroup(current: current, feelsLike: feels, min: min, max: max)
    }
    
    /// A String description of the current weather conditions.
    var description: String {
        return weatherDescription.first?.description ?? ""
    }
    
    /// An Int percentage cloud coverage.
    var coverage: Int {
        return cloudCoverage.all
    }
    
    /// A Tuple containing (Wind Speec, Wind Degrees).
    var windInfo: (Double, Int) {
        return (wind.speed, wind.deg)
    }
    
    /// An Int humidity percentage.
    var humidity: Int {
        return weatherInfo.humidity
    }
    
    /// An Int air pressure level.
    var pressure: Int {
        return weatherInfo.pressure
    }
    
}
