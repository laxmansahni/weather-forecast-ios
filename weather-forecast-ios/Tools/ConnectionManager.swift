//
//  ConnectionManager.swift
//  weather-forecast-ios
//
//   Created by Laxman on 16/09/24.
//

import Network

final class ConnectionManager {
    
    static let shared = ConnectionManager()
    
    private let queue = DispatchQueue.global()
    private let monitor: NWPathMonitor
    
    public private(set) var isConnected: Bool = false
    
    private init() {
        monitor = NWPathMonitor()
        startMonitoring()
    }
    
    public func startMonitoring() {
        monitor.start(queue: queue)
        monitor.pathUpdateHandler = { [weak self] path in
            self?.isConnected = path.status == .satisfied
        }
    }
    
    public func stop() {
        monitor.cancel()
    }
    
}
