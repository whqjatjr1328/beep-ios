//
//  NaverLogin.swift
//  beep-ios
//
//  Created by BeomSeok on 2023/06/15.
//

import Foundation
import NaverThirdPartyLogin
import Alamofire
import SwiftyJSON

class NaverLogin: NSObject {
    private let instance = NaverThirdPartyLoginConnection.getSharedInstance()
    
    private func getInfo() {
        guard let isValidAccesToken = instance?.isValidAccessTokenExpireTimeNow() else {
            login()
            return
        }
        
        if isValidAccesToken == false {
            refreshToken()
            return
        } else {
            userInfo()
        }
    }
    
    func login() {
        instance?.delegate = self
        instance?.requestThirdPartyLogin()
    }
    
    func refreshToken() {
        instance?.delegate = self
        instance?.requestAccessTokenWithRefreshToken()
    }
    
    func logout() {
        instance?.delegate = self
        //delete data
        instance?.resetToken()
    }
    
    func disconnect() {
        instance?.delegate = self
        //remove data
        instance?.requestDeleteToken()
    }
    
    func userInfo() {
        guard let tokenType = instance?.tokenType else { return }
        guard let accessToken = instance?.accessToken else { return }
        
        
        let requestUrl = "https://openapi.naver.com/v1/nid/me"
        let url = URL(string: requestUrl)!
        
        let authorization = "\(tokenType) \(accessToken)"
        
        let req = AF.request(url, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: ["Authorization": authorization])
        req.responseData { response in
            switch response.result {
            case .failure(let error):
                print("Error = \(error)")
                
            case .success(let data):
                let json = try? JSON(data: data)
                print("response = \(json)")
            }
        }
        
    }
}


extension NaverLogin: NaverThirdPartyLoginConnectionDelegate {
    
    func oauth20ConnectionDidFinishRequestACTokenWithAuthCode() {
        print("1")
        self.getInfo()
    }
    
    func oauth20ConnectionDidFinishRequestACTokenWithRefreshToken() {
        print(2)
        self.getInfo()
    }
    
    func oauth20ConnectionDidFinishDeleteToken() {
        print("3")
    }
    
    func oauth20Connection(_ oauthConnection: NaverThirdPartyLoginConnection!, didFailWithError error: Error!) {
        print("4")
    }
    
    
    
}
