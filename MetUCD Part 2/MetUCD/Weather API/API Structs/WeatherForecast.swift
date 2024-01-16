//
//  WeatherForecast.swift
//  MetUCD
//
//  Created by James Clackett on 15/11/2023.
//

import Foundation

/// A Codable Struct that represents a WeatherForecast result from openWeatherAPI.
/// Specifically, represents infomation from the 5 Day 3 Hour Forecast Weather API.
/// WeatherForecast  is a representation of the next 5 days weather forecast at a specified location.
/// Provides getters to access user-friendly results.
struct WeatherForecast: Codable {
    
    struct ForecastItem : Codable {
        let dt: Int
        let main: Main
        let weather: [Weather]
    }
    
    struct Weather: Codable {
        let icon: String
    }
    
    struct Main: Codable {
        let temp_min: Double
        let temp_max: Double
    }
    
    struct City: Codable {
        let name: String
        let country: String
        let timezone: Int
    }
    
    private let list: [ForecastItem]
    private let city: City
    
    
    /// Contains a list of formatted ForecastItems
    /// The initial list is computed by mapping the response 'list' to a new list of type ForecastItemFormatted
    /// Date objects are created from a timestamp and the time difference at location is added.
    /// The list is then grouped into days of week. Any days that do not have a full 8 forecast items are discarded.
    /// This is to ensure a consistent number of results for each day.
    private var formattedList: [ForecastItemFormatted] {
        
        // Format ForecastItem List:
        let formattedList = list.map {
            ForecastItemFormatted(
                date: Date(timeIntervalSince1970: TimeInterval($0.dt + city.timezone)),
                                tempMax: $0.main.temp_max,
                                tempMin: $0.main.temp_min,
                                icon: $0.weather[0].icon)
        }
        
        // Group list by day of week:
        var groupedByDate: [String: [ForecastItemFormatted]] = [:]

        for forecastItem in formattedList {
            let dateString = WeatherModel.formatDate(date: forecastItem.date, format: "yyyy-MM-dd")

            if var itemsForDate = groupedByDate[dateString] {
                itemsForDate.append(forecastItem)
                groupedByDate[dateString] = itemsForDate
            } else {
                groupedByDate[dateString] = [forecastItem]
            }
        }
        
        // Filter result to remove incomplete Days and flatten map again:
        let filteredForecastList = groupedByDate.filter { $0.value.count == 8 }
        var finalFilteredArray = filteredForecastList.flatMap { $0.value }
        finalFilteredArray.sort { $0.date < $1.date }
        
        return finalFilteredArray
    }
    
    //
    // FOR USERS:
    //
    
    /// The user-ready list representing weather forecast information for up to 5 days.
    /// There are N items in array for the N days forecast.
    var dayList: [DayItem] {
        
        // The following code sacrifices efficiency for readability.
        // Since the max number of items for the 5 day forecast is 40, this is ok
        
        var list = [DayItem]()
        
        for item in formattedList {
            let day = WeatherModel.formatDate(date: item.date, format: "E")
            let tempMax = item.tempMax
            let tempMin = item.tempMin
            let icon = item.icon
            
            let dayItem = DayItem(name: day, tempMax: tempMax, tempMin: tempMin, iconArray: [icon])
            
            if list.contains(dayItem) {
                let index = list.firstIndex(of: dayItem)!
                list[index].iconArray.append(icon)
                list[index].tempMax = max(tempMax, list[index].tempMax)
                list[index].tempMin = min(tempMax, list[index].tempMin)
            } else {
                list.append(dayItem)
            }
        }
        return list
    }
}

/// A Struct to represent a Formatted Forecast Item
/// A Formatted Forecast Item is a developer-friendly struct that represents a more readable forecast result.
struct ForecastItemFormatted {
    let date: Date
    let tempMax: Double
    let tempMin: Double
    let icon: String
}

/// A Struct that represents the entire forecast for a day
/// Contains a day of week, temperature minimum and maximum for that day,.
/// Contains an array of 8 icon strings that represent the weather condition at 3hr intervals.
struct DayItem: Equatable {
    var name: String
    var tempMax: Double
    var tempMin: Double
    var iconArray: [String]
    
    static func == (lhs: DayItem, rhs: DayItem) -> Bool {
        return lhs.name == rhs.name
    }
}
