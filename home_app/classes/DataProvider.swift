//
//  DataProvider.swift
//  home_app
//


import UIKit
import RxSwift

class DataProvider: NSObject {
    
    static let shared = DataProvider()
    
    func getRooms(finish: @escaping (Array<Any>?) -> Void) {
        let client = ConnectionManager.shared.connetion()
        
        client.getRooms { (results) in
            finish(results)
        }
    }
    func getRoomDetails(roomId: Int, finish: @escaping (Dictionary<String,Any>?) -> Void) {
        let client = ConnectionManager.shared.connetion()
        
        client.getRoomDetails(roomId: roomId) { (results) in
            finish(results)
        }
        
    }
    func setSensor(roomId:Int, sensorId:Int, value:Int) {
        let client = ConnectionManager.shared.connetion()
        
        client.setSensor(roomId: roomId, sensorId: sensorId, value: value)
    }

}
