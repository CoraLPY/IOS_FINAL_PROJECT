//
//  IOS_FINALApp.swift
//  IOS_FINAL
//
//  Created by lo pui yi on 12/6/2022.
//

import SwiftUI
import Firebase

@main
struct IOS_FINALApp: App {
    @StateObject private var viewRouter = ViewRouter()
    
    init() {
        FirebaseApp.configure()
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView().environmentObject(viewRouter)
        }
    }
}
