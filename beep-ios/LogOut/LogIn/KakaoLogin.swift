//
//  KakaoLogin.swift
//  beep-ios
//
//  Created by BeomSeok on 2023/06/16.
//

import Foundation
import KakaoSDKUser

class KakaoLogin: NSObject {
    func login() {
        if UserApi.isKakaoTalkLoginAvailable() {
            UserApi.shared.loginWithKakaoTalk { token, error in
                if let error = error {
                    print("error = \(error)")
                } else {
                    print("success login \(token)")
                }
            }
        } else {
            UserApi.shared.loginWithKakaoAccount { token, error in
                if let error = error {
                    print("error = \(error)")
                } else {
                    print("success login \(token)")
                }
            }
        }
    }
    
    
    func logout() {
        UserApi.shared.logout { error in
            if let error = error {
                print("error = \(error)")
            } else {
                print("success logout")
            }
        }
    }
}
