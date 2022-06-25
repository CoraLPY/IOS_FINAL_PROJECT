//
//  ContentView.swift
//  IOS_FINAL
//
//  Created by lo pui yi on 12/6/2022.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var viewRouter: ViewRouter
    
    var body: some View {
        switch viewRouter.currentView {
        case "RegistrationView":
            RegistrationView()
        case "HomeView":
            HomeView()
        default:
            SignInView()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environmentObject(ViewRouter())
    }
}
