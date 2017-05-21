//
//  RoomsDetailVM.swift
//  home_app
//


import UIKit
import RxSwift

class RoomsDetailVM: NSObject {
    
    public var name = BehaviorSubject<String>(value: "")
    public var image = BehaviorSubject<String>(value: "")
    public var sensors = BehaviorSubject<Array<Any>>(value: Array<Any>())
    public var roomId = BehaviorSubject<Int?>(value: nil)
    
    func subscribeToData() {
        guard let idVal = try? roomId.value(),
            let id = idVal  else { return }
        DataProvider.shared.getRoomDetails(roomId: id) { (results) in
            if let room = results,
            let name = room["name"] as? String,
                let sens = room["sensors"] as? Array<Any> {
                
                self.name.onNext(name)
                self.sensors.onNext(sens)
            }
        }
    }
    
    public func onViewAppear() {
        subscribeToData()
    }

}
