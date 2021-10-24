//
//  NetworkConnect.swift
//  WeatherAppTest
//
//  Created by Никита Ничепорук on 10/22/21.
//  Copyright © 2021 Никита Ничепорук. All rights reserved.
//

import Foundation
import Network

final class NetworkConnect {
    static let shared = NetworkConnect()
    
    private let queue = DispatchQueue.global()
    private let monitor: NWPathMonitor
    var isConnected: Bool = false
    private var connectionType: ConnectionType = .unknow
    
    enum ConnectionType {
        case wifi
        case celluar
        case ethernet
        case unknow
    }
    
    private init() {
        monitor = NWPathMonitor()
    }
    
    func startMonitoring() {
        monitor.start(queue: queue)
        monitor.pathUpdateHandler = { [weak self] (path) in
            guard let self = self else { return }
            self.isConnected = path.status == .satisfied
            self.getConnetcionType(path)
        }
    }
    
    func stopMonitioring() {
        monitor.cancel()
    }
    
    private func getConnetcionType(_ path: NWPath) {
        if path.usesInterfaceType(.wifi) {
            connectionType = .wifi
        } else if path.usesInterfaceType(.cellular) {
            connectionType = .celluar
        } else if path.usesInterfaceType(.wiredEthernet) {
            connectionType = .ethernet
        }
        else {
            connectionType = .unknow
        }
    }
}
