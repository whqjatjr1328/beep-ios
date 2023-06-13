//
//  AppComponent.swift
//  beep-ios
//
//  Created by BeomSeok on 2023/06/13.
//

import RIBs

class AppComponent: Component<EmptyDependency>, RootDependency {
    
    init() {
        super.init(dependency: EmptyComponent())
    }
}
