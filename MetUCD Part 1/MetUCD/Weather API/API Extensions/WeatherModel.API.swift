//
//  WeatherModel.Requests.swift
//  MetUCD
//
//  Created by James Clackett on 16/11/2023.
//

import Foundation

/// An Extension for WeatherModel that contains code related to API calls.
/// The extensions are intended for openWeatherAPI but can be tailored for others provided the correct API structs are implemented for decoding.
extension WeatherModel {
    
    /// An Enum that dynamically creates openWeatherMap endpoints.
    enum APIURLs {
        case pollutionForecast(lat: Double, lon: Double)
        case pollutionCurrent(lat: Double, lon: Double)
        case weatherCurrent(lat: Double, lon: Double)
        case weatherForecast(lat: Double, lon: Double)
        case geoCoder(name: String)
        case imageIcon(icon: String)
        
        // In a real-world application, you could register a user and create their own API keys
        // for the purposes of this assignment, I have hardcoded one
        var urlString: String {
            //let apiKey = "6ba52e6e8c6ab66d7a758fc62aebf313" This APIKEY got blocked thanks to a Preview infinite loop :) RIP
            let apiKey = "4c32a3905e9b85a6c02bcf7194820c62"
            
            switch self {
            case .pollutionForecast(let lat, let lon):
                return "https://api.openweathermap.org/data/2.5/air_pollution/forecast?lat=\(lat)&lon=\(lon)&appid=\(apiKey)"
            case .pollutionCurrent(let lat, let lon):
                return "https://api.openweathermap.org/data/2.5/air_pollution?lat=\(lat)&lon=\(lon)&appid=\(apiKey)"
            case .weatherCurrent(let lat, let lon):
                return "https://api.openweathermap.org/data/2.5/weather?lat=\(lat)&lon=\(lon)&appid=\(apiKey)&units=metric"
            case .weatherForecast(let lat, let lon):
                return "https://api.openweathermap.org/data/2.5/forecast?lat=\(lat)&lon=\(lon)&appid=\(apiKey)&units=metric"
            case .geoCoder(let name):
                return "https://api.openweathermap.org/geo/1.0/direct?q=\(name)&appid=\(apiKey)"
            case .imageIcon(let icon):
                return "https://openweathermap.org/img/wn/\(icon)@2x.png"
            }
        }
    }
    
    /// An async function responsible for requesting json data from a specified URL.
    /// Attempts to decode the specified Decodable Object Type from the response
    /// - Parameters:
    ///   -  url: A string URL endpoint.
    /// - Throws: URLError:  if the URL is incorrect
    /// - Returns: A result of Decodable T, or a result of falilure.
    static func fetchData<T: Decodable> (url: String) async -> Result<T, Error> {
        
        guard let url = URL(string: url)
        else {
            return .failure(URLError(.badURL, userInfo: [NSLocalizedDescriptionKey: "Invalid URL"]))
        }

        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            let decoder = JSONDecoder()
            let response = try decoder.decode(T.self, from: data)
            return .success(response)
            
        } catch {
            print("Invalid Response")
            return .failure(error)
        }
    }
    
    /// An async function that attempts to fetch a Decodable result from a URL, throwing an error if it fails to do so,
    ///  - Parameters:
    ///    - url: A String URL endpoint  to fetch data from.
    ///  - Returns: a successful data result of any type
    static func getResult<T: Decodable>(url: String) async throws -> T {
        let result: Result<T, Error> = await fetchData(url: url)
        switch result {
        case .success(let data):
            return data
        case .failure(let error):
            print(error)
            throw error
        }
    }
    
    /// Am async function that converts a String location into a Location Object
    /// Location Objects contain information about a searched location, most importantly its coordinates.
    /// Uses openWeathers APIs GeoCoder.
    /// Note: MapKit's LocalSearch is better and thus I have not used this func in Part 2.
    /// - Parameters:
    ///   - location: A String location
    /// - Returns: A Location Object
    static func getLocation(location: String) async throws -> [Location] {
        let url = APIURLs.geoCoder(name: location).urlString
        return try await WeatherModel.getResult(url: url)
    }
    
}
