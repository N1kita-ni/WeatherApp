//
//  ForecastWeatherNetworkService.swift
//  WeatherAppTest
//
//  Created by Никита Ничепорук on 10/21/21.
//  Copyright © 2021 Никита Ничепорук. All rights reserved.
//

import Foundation

protocol ForecastWeatherNetworkServiceProtocol {
 func getForecastWeather(lat: String, lon: String, complition: @escaping (Result<ForecastWeather?, Error>) -> ())
}

class ForecastWeatherNetworkService: ForecastWeatherNetworkServiceProtocol {
    func getForecastWeather(lat: String, lon: String, complition: @escaping (Result<ForecastWeather?, Error>) -> ()) {
        let urlString = "https://api.openweathermap.org/data/2.5/forecast?lat=\(lat)&lon=\(lon)&units=metric&appid=45a10ef347f24b4147004f0eed17d99c"
        guard let url = URL(string: urlString) else { return }
        
        URLSession.shared.dataTask(with: url) { (data, _, error) in
            if let error = error {
                complition(.failure(error))
                return
            }
            guard let data = data else { return }
            do {
                let forecastDecode = try JSONDecoder().decode(ForecastWeather.self, from: data)
                complition(.success(forecastDecode))
            } catch {
                complition(.failure(error))
            }
        }.resume()
    }
}
