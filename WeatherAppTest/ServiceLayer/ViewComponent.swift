//
//  ViewComponent.swift
//  WeatherAppTest
//
//  Created by Никита Ничепорук on 10/31/21.
//  Copyright © 2021 Никита Ничепорук. All rights reserved.
//

import Foundation
import UIKit

class ViewComponent {
    init(parent: UIViewController) {
        self.parent = parent
    }
    var parent: UIViewController
}
