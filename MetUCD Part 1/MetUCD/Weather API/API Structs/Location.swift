//
//  Location.swift
//  MetUCD
//
//  Created by James Clackett on 16/11/2023.
//

import Foundation

/// A Codable Struct that represents a Location result from openWeatherAPI.
/// Specifically, represents infomation from the GeoCoder API.
/// Location is a representation of the location found by the GeoCoder API from a given String
struct Location: Codable {
    let name: String
    let country: String
    let lat: Double
    let lon: Double    
}


