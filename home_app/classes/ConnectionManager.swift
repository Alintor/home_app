//
//  ConnectionManager.swift
//  home_app
//


import UIKit

class ConnectionManager: NSObject {
    
    static let shared = ConnectionManager()
    
    func connetion() -> DataClient {
        return APIClient.shared
    }

}
