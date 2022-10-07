//
//  UIView+Helper.swift
//  WeatherAppTest
//
//  Created by Никита Ничепорук on 10/7/22.
//  Copyright © 2022 Никита Ничепорук. All rights reserved.
//

import UIKit

extension UIView {
    static var nib: UINib? {
        return UINib(nibName: String(describing: self), bundle: .main)
    }
}
