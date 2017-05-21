//
//  FirebaseClient.swift
//  home_app
//
//  Created by Alexandr Ovchinnikov on 21/05/2017.
//  Copyright © 2017 Ovchinnikov. All rights reserved.
//

import UIKit
import Firebase

let ROOMS_DB_NAME = "rooms"
let USERS_DB_NAME = "users"
let OBSERVABLE_DB_NAME = "observable"

class FirebaseClient: NSObject, DataClient {
    var ref: FIRDatabaseReference!
    
    static let shared = FirebaseClient()
    
    override init() {
        FIRAuth.auth()?.signIn(withEmail: email, password: password, completion: { (user, error) in
            if user == nil {
                print(error?.localizedDescription)
            } else {
                print("SignIn success!")
            }
        })
        ref = FIRDatabase.database().reference()
        super.init()
    }
    
    func getRooms(finish: @escaping (Array<Any>?) -> Void) {
        let userID = FIRAuth.auth()?.currentUser?.uid
        ref.child(USERS_DB_NAME).child(userID!).child(ROOMS_DB_NAME).observe(.value, with: { (snapshot) in
            if let value = snapshot.value as? Array<Any> {
                finish(value)
            } else {
                finish(nil)
            }
        })
    }
    
    func getRoomDetails(roomId: Int, finish: @escaping (Dictionary<String,Any>?) -> Void) {
        
        let userID = FIRAuth.auth()?.currentUser?.uid
        
        let observable = ["command" : "roomDetails",
                          "param" : 0,
                          "value" : 0] as [String : Any]
        
        ref.child(USERS_DB_NAME).child(userID!).child(OBSERVABLE_DB_NAME).setValue(observable)
        ref.child(USERS_DB_NAME).child(userID!).child(ROOMS_DB_NAME).child("\(roomId)").observe(.value, with: { (snapshot) in
            if let value = snapshot.value as? Dictionary<String,Any> {
                finish(value)
            } else {
                finish(nil)
            }
        })
    }
    
    func setSensor(roomId:Int, sensorId:Int, value:Int) {
        let userID = FIRAuth.auth()?.currentUser?.uid
        
        let observable = ["command" : "setSensor",
                          "param" : ["roomId" : roomId, "sensorId" : sensorId],
                          "value" : value] as [String : Any]
        
        ref.child(USERS_DB_NAME).child(userID!).child(OBSERVABLE_DB_NAME).setValue(observable)
    }

}
