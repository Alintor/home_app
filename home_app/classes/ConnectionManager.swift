//
//  ConnectionManager.swift
//  home_app
//
//  Created by Alexandr Ovchinnikov on 21/05/2017.
//  Copyright © 2017 Ovchinnikov. All rights reserved.
//

import UIKit

class ConnectionManager: NSObject {
    
    static let shared = ConnectionManager()
    
    func connetion() -> DataClient {
        return APIClient.shared
    }

}
