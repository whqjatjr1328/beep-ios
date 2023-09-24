//
//  LoginViewModel+Naver.swift
//  beep-ios
//
//  Created by BeomSeok on 2023/09/10.
//

import Foundation
import Alamofire
import NaverThirdPartyLogin

extension LoginViewModel {
    func setupNaverLoginSettings() {
        naverLoginInstance?.delegate = self
    }
    
    func loginWithNaver() {
        naverLoginInstance?.requestThirdPartyLogin()
    }
}

extension LoginViewModel: NaverThirdPartyLoginConnectionDelegate {
    func oauth20ConnectionDidFinishRequestACTokenWithAuthCode() {
        print("[Naver Login] oauth20ConnectionDidFinishRequestACTokenWithAuthCode")
        didLoginWithNaver()
    }
    
    func oauth20ConnectionDidFinishRequestACTokenWithRefreshToken() {
        print("[Naver Login] oauth20ConnectionDidFinishRequestACTokenWithRefreshToken")
    }
    
    func oauth20ConnectionDidFinishDeleteToken() {
        print("[Naver Login] oauth20ConnectionDidFinishDeleteToken")
    }
    
    func oauth20Connection(_ oauthConnection: NaverThirdPartyLoginConnection!, didFailWithError error: Error!) {
        print("[Naver Login] oauth20Connection")
    }
    
    func didLoginWithNaver() {
        guard let accessToken = naverLoginInstance?.isValidAccessTokenExpireTimeNow() else { return }
        
        if !accessToken {
            return
        }
        
        guard let tokenType = naverLoginInstance?.tokenType else { return }
        guard let accessToken = naverLoginInstance?.accessToken else { return }
        
        let requestUrl = "https://openapi.naver.com/v1/nid/me"
        let url = URL(string: requestUrl)!
        
        let authorization = "\(tokenType) \(accessToken)"
        
        let req = AF.request(url, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: ["Authorization": authorization])
        
        
        req.responseJSON { response in
            
            guard let body = response.value as? [String: Any] else { return }
            
            if let resultCode = body["message"] as? String{
                if resultCode.trimmingCharacters(in: .whitespaces) == "success"{
                    let resultJson = body["response"] as! [String: Any]
                    
                    let name = resultJson["name"] as? String ?? ""
                    let id = resultJson["id"] as? String ?? ""
                    let phone = resultJson["mobile"] as? String
                    let gender = resultJson["gender"] as? String ?? ""
                    let birthyear = resultJson["birthyear"] as? String ?? ""
                    let birthday = resultJson["birthday"] as? String ?? ""
                    let profile = resultJson["profile_image"] as? String ?? ""
                    let email = resultJson["email"] as? String ?? ""
                    let nickName = resultJson["nickname"] as? String ?? ""
                    
                    print("네이버 로그인 이름 ",name)
                    print("네이버 로그인 아이디 ",id)
                    print("네이버 로그인 핸드폰 ",phone)
                    print("네이버 로그인 성별 ",gender)
                    print("네이버 로그인 생년 ",birthyear)
                    print("네이버 로그인 생일 ",birthday)
                    print("네이버 로그인 프로필사진 ",profile)
                    print("네이버 로그인 이메일 ",email)
                    print("네이버 로그인 닉네임 ",nickName)
                    self.didLogin.onNext(Void())
                }
                else{
                    //실패
                }
            }
        }
    }
}
