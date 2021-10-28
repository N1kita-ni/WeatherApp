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

struct ForecastSections {
    var header: String
    var data: [ForecastData]
}

protocol ForecastViewPresenterProtocol: class {
    init(view: ForecastViewProtocol, networkService: ForecastWeatherNetworkServiceProtocol)
    var forecastSections: [ForecastSections] { get set }
    var forecastWeather: ForecastWeather? { get set }
    
}

final class ForecastPresenter: NSObject, CLLocationManagerDelegate, ForecastViewPresenterProtocol {
    var locationManager = CLLocationManager()
    private let forecastProperty = "forecast"
    var forecastWeather: ForecastWeather?
    var forecastSections: [ForecastSections] = []
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
        guard let location = locations.first?.coordinate else { return }
        networkService.getForecastWeather(lat: location.latitude.description, lon: location.longitude.description, forecast: forecastProperty) { [weak self] (result) in
            DispatchQueue.main.async {
                guard let self = self else { return }
                switch result {
                case .success(let forecast):
                    self.configureSections(with: forecast)
                    self.forecastWeather = forecast
                    self.view?.success()
                case.failure(let error):
                    print(error.localizedDescription)
                    self.view?.failure(error: error)
                }
            }
        }
    }

private func configureSections(with weather: ForecastWeather?) {
        guard let weather = weather else { return }
        var searchingComponents: (Int, Int, Int) = (0, 0, 0)
        var sectionsValue: [ForecastSections] = []
        var section: ForecastSections?
    
    for weather in weather.list {
        let dateFormatterGet = DateFormatter()
        dateFormatterGet.dateFormat = "yyyy-MM-dd HH:mm:ss"
        guard let date = dateFormatterGet.date(from: weather.dateTxt) else { return }
        let calendar = Calendar.current
        let component = calendar.dateComponents([.year, .month, .day], from: date)
        guard let year = component.year, let month = component.month, let day = component.day else { return }
        if year != searchingComponents.0 || month != searchingComponents.1 || day != searchingComponents.2 {
            if let section = section {
                sectionsValue.append(section)
            }
            section = ForecastSections(header: date.dateName(), data: [weather])
            searchingComponents = (year, month, day)
        } else {
            section?.data.append(weather)
        }
    }
    forecastSections = sectionsValue
    self.view?.success()
    }
}


