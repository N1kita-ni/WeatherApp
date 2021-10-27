//
//  ForecastWeather.swift
//  WeatherAppTest
//
//  Created by Никита Ничепорук on 10/25/21.
//  Copyright © 2021 Никита Ничепорук. All rights reserved.
//

import Foundation

struct ForecastWeather: Codable {
    let list: [ForecastData]
    let city: City
}

struct City: Codable {
    let name: String
}

struct ForecastData: Codable {
    let main: MainForecast
    let weather: [WeatherForecast]
    let dateTxt: String

    enum CodingKeys: String, CodingKey {
        case main, weather
        case dateTxt = "dt_txt"
    }
}

struct WeatherForecast: Codable {
    let id: Int
    let main: String
    let description: String
    let icon: String
    var forecastWeatherIconURL: URL {
        let urlString =  "https://openweathermap.org/img/wn/\(icon)@2x.png"
        return URL(string: urlString)!
    }
}

struct MainForecast: Codable {
    let temp: Double
}

