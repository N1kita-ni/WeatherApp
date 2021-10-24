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
    init(view: MainViewProtocol, networkService: CurrentWeatherNetworkServiceProtocol)
    var currentWeather: WeatherData? { get set }
    func internerConnection()
}

class MainPresenter: NSObject, MainViewPresenterProtocol, CLLocationManagerDelegate {
    var locationManager = CLLocationManager()
    var currentLoc: CLLocation?
    var latitude : CLLocationDegrees!
    var longitude: CLLocationDegrees!
    var currentWeather: WeatherData?
    weak var view: MainViewProtocol?
    let networkService: CurrentWeatherNetworkServiceProtocol
    
    required init(view: MainViewProtocol, networkService: CurrentWeatherNetworkServiceProtocol) {
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
        networkService.getCurrentWeather(lat: latitude.description, lon: longitude.description) { [weak self] (result) in
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
    }
    
    func internerConnection() {
        if NetworkConnect.shared.isConnected {
            //temperatureLabel.text = "Its ok"
            print("Connect success")
        } else {
            // temperatureLabel.text = "Denied"
            print("Connect Denied")
        }
    }
}

