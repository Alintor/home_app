//
//  DataClient.swift
//  home_app
//


import Foundation

public protocol DataClient {
    func getRooms(finish: @escaping (Array<Any>?) -> Void)
    func getRoomDetails(roomId: Int, finish: @escaping (Dictionary<String,Any>?) -> Void)
    func setSensor(roomId:Int, sensorId:Int, value:Int)
}
