//
//  DataClient.swift
//  home_app
//
//  Created by Alexandr Ovchinnikov on 21/05/2017.
//  Copyright © 2017 Ovchinnikov. All rights reserved.
//

import Foundation

public protocol DataClient {
    func getRooms(finish: @escaping (Array<Any>?) -> Void)
    func getRoomDetails(roomId: Int, finish: @escaping (Dictionary<String,Any>?) -> Void)
    func setSensor(roomId:Int, sensorId:Int, value:Int)
}
