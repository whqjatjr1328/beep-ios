//
//  LoginImageCell.swift
//  beep-ios
//
//  Created by BeomSeok on 2023/07/30.
//

import UIKit
import SnapKit
import Lottie

class LoginImageCell: UICollectionViewCell {
    var lottieView: LottieAnimationView?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.backgroundColor = .gray
        let animationView = LottieAnimationView()
        animationView.contentMode = .scaleAspectFit
        contentView.addSubview(animationView)
        animationView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        self.lottieView = animationView
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func updateCell(type: LoginAnimationType) {
        guard let animationPath = type.animationPath else { return }
        
        let animation = LottieAnimation.filepath(animationPath, animationCache: LottieAnimationCache.shared)
        lottieView?.animation = animation
    }
    
    func playAnimation() {
        lottieView?.play()
    }
    
    func stopAnimation() {
        lottieView?.stop()
    }
}
