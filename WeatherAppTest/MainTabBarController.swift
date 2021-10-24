//
//  MainTabBarController.swift
//  WeatherAppTest
//
//  Created by Никита Ничепорук on 10/20/21.
//  Copyright © 2021 Никита Ничепорук. All rights reserved.
//

import UIKit

class MainTabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let weatherVC = UINavigationController(rootViewController: ModuleBuilder.createMainModule())
        let forecastVC = UINavigationController(rootViewController: ModuleBuilder.createForecastModule())
        // let mainVC = ModuleBuilder.createMainModule()
        
        //let navigationBar = UINavigationController(rootViewController: mainVC)
        setViewControllers([weatherVC, forecastVC], animated: true)
        let item1 = UITabBarItem(title: "Today", image: UIImage(systemName: "sun.max"), tag: 0)
        let item2 = UITabBarItem(title: "Forecast", image: UIImage(systemName: "cloud.sun"), tag: 1)
        weatherVC.tabBarItem = item1
        forecastVC.tabBarItem = item2
    }
}
