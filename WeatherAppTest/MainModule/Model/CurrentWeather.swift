//
//  Model.swift
//  WeatherAppTest
//
//  Created by Никита Ничепорук on 10/19/21.
//  Copyright © 2021 Никита Ничепорук. All rights reserved.
//

import Foundation

//struct Forecast: Codable {
//    let daily: [Daily]
//    let timezone: String
//    let current: Current
//
//    enum CodingKeys: String, CodingKey {
//        case daily
//        case timezone
//        case current
//    }
//}
//
//struct Current: Codable {
//    let date: Date
//    let temperature: Double
//    let windSpeed: Double
//    let humidity: Int
//    let pressure: Double
//    let weather: [Weather]
//
//    enum CodingKeys: String, CodingKey {
//        case date = "dt"
//        case temperature = "temp"
//        case windSpeed = "wind_speed"
//        case humidity
//        case weather
//        case pressure
//    }
//}
//
//struct Daily: Codable {
//    let date: Date
//    let temperature: Temperature
//    let humidity: Int
//    let weather: [Weather]
//    let clouds: Int
//    let pop: Double
//    let pressure: Double
//    let windSpeed: Double
//
//    enum CodingKeys: String, CodingKey {
//        case date = "dt"
//        case temperature = "temp"
//        case humidity
//        case weather
//        case clouds
//        case pop
//        case pressure
//        case windSpeed = "wind_speed"
//    }
//}
//
//struct Temperature: Codable {
//    let min: Double
//    let max: Double
//    let day: Double
//}
//
//struct Weather: Codable {
//    let id: Int
//    let main: String
//    let icon: String
//    var weatherIconURL: URL {
//        let urlString = "https://openweathermap.org/img/wn/\(icon)@2x.png"
//        return URL(string: urlString)!
//    }
//}

struct WeatherData: Codable {
    let weather: [Weather]
    let main: Main
    let wind: Wind
    let sys: Sys
    let name: String
}

struct Main: Codable {
    let temp: Double
    let pressure: Int
    let humidity: Int
}

struct Sys: Codable {
    let country: String
}

struct Weather: Codable {
    let main: String
    let description: String
    let icon: String
    var weatherIconURL: URL {
        let urlString = "https://openweathermap.org/img/wn/\(icon)@2x.png"
        return URL(string: urlString)!
    }
}

struct Wind: Codable {
    let speed: Double
    let deg: Int
}

