//
//  RoomsVM.swift
//  home_app
//


import UIKit
import RxSwift

class RoomsVM: NSObject {
    
    public var roomItems = BehaviorSubject<Array<Any>>(value: Array<Any>())
    
    func subscribeToData() {
        DataProvider.shared.getRooms { (results) in
            if let items = results {
                self.roomItems.onNext(items)
            }
        }
    }
    
    public func onViewAppear() {
        subscribeToData()
    }
}
