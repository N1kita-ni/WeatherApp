//
//  MainPresenter.swift
//  WeatherAppTest
//
//  Created by Никита Ничепорук on 10/19/21.
//  Copyright © 2021 Никита Ничепорук. All rights reserved.
//

import Foundation
import CoreLocation

protocol MainViewProtocol: class {
    func success()
    func failure(error: Error)
}

protocol MainViewPresenterProtocol: class {
    init(view: MainViewProtocol, networkService: GetDataProtocol)
    var currentWeather: WeatherData? { get set }
}

 final class MainPresenter: NSObject, MainViewPresenterProtocol, CLLocationManagerDelegate {
    var locationManager = CLLocationManager()
    private let weatherProperty = "weather"
    var currentWeather: WeatherData?
    weak var view: MainViewProtocol?
    let networkService: GetDataProtocol
    
    init(view: MainViewProtocol, networkService: GetDataProtocol) {
        self.view = view
        self.networkService = networkService
        super.init()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
    }
    
     func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.first?.coordinate else { return }
        networkService.genericGetData(urlString: "https://api.openweathermap.org/data/2.5/\(weatherProperty)?lat=\(location.latitude.description)&lon=\(location.longitude.description)&units=metric&appid=45a10ef347f24b4147004f0eed17d99c", of_: WeatherData.self) { [weak self] (result) in
            DispatchQueue.main.async {
                guard let self = self else { return }
                switch result {
                case .success(let weather):
                    self.currentWeather = weather
                    self.view?.success()
                case .failure(let error):
                    self.view?.failure(error: error)
                }
            }
        }
//        networkService.getCurrentWeather(lat: location.latitude.description, lon: location.longitude.description, weather: weatherProperty, of_: WeatherData.self) { [weak self] (result) in
//            DispatchQueue.main.async {
//                guard let self = self else { return }
//                switch result {
//                case .success(let weather):
//                    self.currentWeather = weather
//                    self.view?.success()
//                case .failure(let error):
//                    self.view?.failure(error: error)
//                }
//            }
//        }
    }
}

