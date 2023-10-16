//
//  GalleryPageButton.swift
//  beep-ios
//
//  Created by BeomSeok on 2023/10/17.
//

import UIKit

enum GalleryPageType: CaseIterable {
    case recommend, all
    
    var title: String {
        switch self {
        case .recommend:    return "추천"
        case .all:          return "앨범"
        }
    }
}


class GalleryPageButton: BaseSelectButton {
    let pageType: GalleryPageType
    
    init(pageType: GalleryPageType) {
        self.pageType = pageType
        super.init(title: pageType.title)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
