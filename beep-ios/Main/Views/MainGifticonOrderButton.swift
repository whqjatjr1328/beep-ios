//
//  MainGifticonOrderButton.swift
//  beep-ios
//
//  Created by BeomSeok on 2023/10/09.
//

import UIKit
import RxSwift

enum MainGifticonListOrder: CaseIterable {
    case dDay, recent
    
    var title: String {
        switch self {
        case .dDay:     return "디데이순"
        case .recent:   return "최신등록순"
        }
    }
}

class MainGifticonOrderButton: BaseSelectButton {
    
    let order: MainGifticonListOrder
    
    init(order: MainGifticonListOrder) {
        self.order = order
        super.init(title: order.title)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
