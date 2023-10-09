//
//  LoginInfo.swift
//  beep-ios
//
//  Created by BeomSeok on 2023/09/30.
//

import UIKit

class LoginInfo: NSObject {
    let id: String
    let name: String
    
    init(id: String, name: String) {
        self.id = id
        self.name = name
        super.init()
    }
    
}
