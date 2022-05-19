//
//  NetworkService.swift
//  WeatherAppTest
//
//  Created by Никита Ничепорук on 10/19/21.
//  Copyright © 2021 Никита Ничепорук. All rights reserved.
//

import Foundation

protocol CurrentWeatherNetworkServiceProtocol {
    func getCurrentWeather(lat: String, lon: String, weather: String, complition: @escaping (Result<WeatherData?, Error>) -> ())
}

class CurrentWeatherNetworkService: CurrentWeatherNetworkServiceProtocol {
    func getCurrentWeather(lat: String, lon: String, weather: String, complition: @escaping (Result<WeatherData?, Error>) -> ()) {
        let urlString = "https://api.openweathermap.org/data/2.5/\(weather)?lat=\(lat)&lon=\(lon)&units=metric&appid=45a10ef347f24b4147004f0eed17d99c"
        guard let url = URL(string: urlString) else { return }
        
        URLSession.shared.dataTask(with: url) { (data, _, error) in
            if let error = error {
                complition(.failure(error))
                return
            }
            guard let data = data else { return }
            do {
                let weatherDecode = try JSONDecoder().decode(WeatherData.self, from: data)
                complition(.success(weatherDecode))
            } catch {
                complition(.failure(error))
            }
        }.resume()
    }
}

