//
//  APIClient.swift
//  home_app
//


let API_ADDRESS = "http://192.168.1.100:8000"
let API_PATH_PREFIX = "/api/v1/"

let PATH_ROOMS = API_PATH_PREFIX+"rooms"
let PATH_SET_SENSOR = API_PATH_PREFIX + "set_sensor"

import UIKit
import Alamofire

class APIClient: NSObject, DataClient {
    
    static let shared = APIClient()
    
    func getRooms(finish: @escaping (Array<Any>?) -> Void) {
        Alamofire.request(API_ADDRESS+PATH_ROOMS).responseJSON { response in
            
            if let JSON = response.result.value,
                let resp = JSON as? Dictionary<String, Any>,
                let results = resp["rooms"] as? Array<Any>{
                
                finish(results)
            } else {
                finish(nil)
            }
        }
        
    }
    func getRoomDetails(roomId: Int, finish: @escaping (Dictionary<String,Any>?) -> Void) {
        Alamofire.request(API_ADDRESS+PATH_ROOMS+"\(roomId)").responseJSON { response in
            
            if let JSON = response.result.value,
                let resp = JSON as? Dictionary<String, Any>{
                
                finish(resp)
            } else {
                finish(nil)
            }
        }
        
    }
    func setSensor(roomId:Int, sensorId:Int, value:Int) {
        let parameters: Parameters = ["value": value]
        Alamofire.request(API_ADDRESS+PATH_SET_SENSOR, method: .post, parameters: parameters)
        
    }

}
