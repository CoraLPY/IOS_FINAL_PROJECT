//
//  ViewRouter.swift
//  IOS_FINAL
//
//  Created by lo pui yi on 25/6/2022.
//

import Foundation

class ViewRouter: ObservableObject {

    @Published var currentView: String

    init() {
        self.currentView = "SignInView"
    }
}
