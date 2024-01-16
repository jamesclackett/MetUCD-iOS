//
//  PollutionForecast.swift
//  MetUCD
//
//  Created by James Clackett on 15/11/2023.
//

import Foundation

/// A Codable Struct that represents a PollutionForecast result from openWeatherAPI.
/// Specifically, represents infomation from the Pollution Forecast API.
/// Pollution is a representation of the current pollution at a given location.
/// Provides getters to access user-friendly results.
struct PollutionForecast: Codable {
    
    struct ForecastItem: Codable {
        let dt: Int
        let main: Main
        let components: Components
    }
    
    // duplicate of Components in Pollution.swift.
    // PollutionForecast will be used with a different API call who's results may differ from Pollution
    // I will keep the duplicated code for this reason
    struct Components: Codable {
        let co: Double
        let no: Double
        let no2: Double
        let o3: Double
        let so2: Double
        let pm2_5: Double
        let pm10: Double
        let nh3: Double
    }
    
    struct Main: Codable {
        let aqi: Int
    }
    
    private let list: [ForecastItem]
    
    
    //
    // FOR USERS:
    //
    
    /// A list of Air Quality Index (AQI) forecast results.
    var aqiList: [(Date, Int)] {
        return list.map {(Date(timeIntervalSince1970: TimeInterval($0.dt)), $0.main.aqi)}
    }
    
}
