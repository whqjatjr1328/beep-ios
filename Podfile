# Uncomment the next line to define a global platform for your project
# platform :ios, '9.0'

target 'beep-ios' do
  # Comment the next line if you don't want to use dynamic frameworks
  use_frameworks!
  inhibit_all_warnings!

# pod 'RIBs', :git => 'https://github.com/uber/RIBs.git', :branch => 'main'
pod 'lottie-ios'
pod 'AdvancedPageControl'
pod 'SnapKit', '~> 5.0.0'
pod 'Alamofire'
pod 'RxSwift', '6.5.0'
pod 'RxCocoa', '6.5.0'
pod 'RxGesture'
pod 'RxDataSources', '~> 5.0'
pod 'naveridlogin-sdk-ios'
pod 'SwiftyJSON', '~> 4.0'
pod 'KakaoSDKCommon', '2.15.0'  # 필수 요소를 담은 공통 모듈
pod 'KakaoSDKAuth', '2.15.0'  # 사용자 인증
pod 'KakaoSDKUser', '2.15.0'  # 카카오 로그인, 사용자 관리

pod 'GoogleSignIn'

  # Pods for beep-ios

end

post_install do |installer|
    installer.pods_project.targets.each do |target|
        target.build_configurations.each do |config|
        config.build_settings['IPHONEOS_DEPLOYMENT_TARGET'] = '11.0' # 원하는 최소 버전
      end
    end
end
