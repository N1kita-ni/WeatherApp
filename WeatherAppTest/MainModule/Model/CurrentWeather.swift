//
//  Model.swift
//  WeatherAppTest
//
//  Created by Никита Ничепорук on 10/19/21.
//  Copyright © 2021 Никита Ничепорук. All rights reserved.
//

import Foundation

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

enum Compass: String { 
    case N, NE, E, SE, S, SW, W, NW
    
    init(degree: Int) {
        switch degree {
        case 0:
            self = .N
        case 0..<90:
            self = .NE
        case 90:
            self = .E
        case 90..<180:
            self = .SE
        case 180:
            self = .S
        case 180..<270:
            self = .SW
        case 270:
            self = .W
        case 270..<360:
            self = .NW
        default:
            self = .N
        }
    }
}
