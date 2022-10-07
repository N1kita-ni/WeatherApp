//
//  View+Extension.swift
//  WeatherAppTest
//
//  Created by Никита Ничепорук on 10/7/22.
//  Copyright © 2022 Никита Ничепорук. All rights reserved.
//

import Foundation
import UIKit

extension UIView {
    func addSubviews(_ views: [UIView]) {
        views.forEach({addSubview($0)})
    }
}
