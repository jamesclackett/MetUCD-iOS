//
//  Pollution.swift
//  MetUCD
//
//  Created by James Clackett on 15/11/2023.
//

import Foundation

/// A Codable Struct that represents a Pollution result from openWeatherAPI.
/// Specifically, represents infomation from the Pollution Forecast (current) API.
/// Pollution is a representation of the current pollution at a given location.
/// Provides getters to access user-friendly results.
struct Pollution: Codable {

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
    
    struct PollutionItem: Codable {
        let main: Main
        let components: Components
    }
    
    struct Main: Codable {
            let aqi: Int
        }
    
    private let pollutionInfo: [PollutionItem]
    
    enum CodingKeys: String, CodingKey {
        case pollutionInfo = "list"
    }
    
    //
    // FOR USERS:
    //
    
    /// A Dictionary of the various pollution metrics and values recieved from the API.
    var components: [String: Double] {
        return pollutionInfo.first?.components.propertyMap ?? [:]
    }
    
    /// The Int Air Quality Index (AQI)
    var aqi: Int {
        return pollutionInfo.first?.main.aqi ?? 0
    }
    
    /// A String representing a human-readable AQI.
    static func airQuality(aqi: Int) -> String {
        switch aqi {
        case 1: return "Good"
        case 2: return "Fair"
        case 3: return "Moderate"
        case 4: return "Poor"
        case 5: return "Very Poor"
        default: return "Unknown"
        }
    }
    
}

extension Pollution.Components {
    /// Uses Mirror Reflection to create a Dictionary of the current objects keys and values.
    /// This makes generating a list of pollution components much easier.
    var propertyMap: [String: Double] {
        let mirror = Mirror(reflecting: self)
        var result: [String: Double] = [:]

        for (label, value) in mirror.children {
            if let label = label, let doubleValue = value as? Double {
                result[label] = doubleValue
            }
        }

        return result
    }
}
