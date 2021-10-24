//
//  ModuleBuilder.swift
//  WeatherAppTest
//
//  Created by Никита Ничепорук on 10/19/21.
//  Copyright © 2021 Никита Ничепорук. All rights reserved.
//

import UIKit

protocol BuilderProtocol {
   static func createMainModule() -> UIViewController
   static func createForecastModule() -> UIViewController
}

class ModuleBuilder: BuilderProtocol {
    static func createMainModule() -> UIViewController {
        let view = WeatherViewController()
        let networkService = CurrentWeatherNetworkService()
        let presenter = MainPresenter(view: view, networkService: networkService)
        view.presenter = presenter
        return view
    }
    
    static func createForecastModule() -> UIViewController {
        let view = ForecastViewController()
        let networkService = ForecastWeatherNetworkService()
        let presenter = ForecastPresenter(view: view, networkService: networkService)
        view.presenter = presenter
        return view
    }
}
