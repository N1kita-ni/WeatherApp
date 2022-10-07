//
//  UITableView+Helper.swift
//  WeatherAppTest
//
//  Created by Никита Ничепорук on 10/7/22.
//  Copyright © 2022 Никита Ничепорук. All rights reserved.
//

import UIKit

extension UITableView {
    func register<T: UITableViewCell>(_ cellClass: T.Type) {
        let reuseIdentifier = String(describing: cellClass)
        register(cellClass, forCellReuseIdentifier: reuseIdentifier)
    }

    func dequeueReusableCell<T: UITableViewCell>(_ cellClass: T.Type, for indexPath: IndexPath) -> T {
        let reuseIdentifier = String(describing: cellClass)
        return dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath) as! T
    }
}

