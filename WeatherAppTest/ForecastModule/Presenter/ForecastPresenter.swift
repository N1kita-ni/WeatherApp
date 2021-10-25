//
//  ForecastPresenter.swift
//  WeatherAppTest
//
//  Created by Никита Ничепорук on 10/20/21.
//  Copyright © 2021 Никита Ничепорук. All rights reserved.
//

import Foundation
import CoreLocation

protocol ForecastViewProtocol: class {
    func success()
    func failure(error: Error)
}

protocol ForecastViewPresenterProtocol: class {
    init(view: ForecastViewProtocol, networkService: ForecastWeatherNetworkServiceProtocol)
    var forecastWeather: ForecastWeather? { get set }
}

class ForecastPresenter: NSObject, CLLocationManagerDelegate, ForecastViewPresenterProtocol {
    var locationManager = CLLocationManager()
    var currentLoc: CLLocation?
    var latitude : CLLocationDegrees!
    var longitude: CLLocationDegrees!
    private let forecastProperty = "forecast"
    var forecastWeather: ForecastWeather?
    weak var view: ForecastViewProtocol?
    let networkService: ForecastWeatherNetworkServiceProtocol
    
    required init(view: ForecastViewProtocol, networkService: ForecastWeatherNetworkServiceProtocol) {
        self.view = view
        self.networkService = networkService
        super.init()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let location = locations[0].coordinate
        latitude = location.latitude
        longitude = location.longitude
        networkService.getForecastWeather(lat: latitude.description, lon: longitude.description, forecast: forecastProperty) { [weak self] (result) in
            DispatchQueue.main.async {
                guard let self = self else { return }
                switch result {
                case .success(let forecast):
                    self.forecastWeather = forecast
                   // self.view?.success()
                    print(Thread.current)
                case.failure(let error):
                    print(error.localizedDescription)
                   // self.view?.failure(error: error)
                }
            }
        }
    }
}

