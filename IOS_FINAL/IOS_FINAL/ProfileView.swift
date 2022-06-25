//
//  ProfileView.swift
//  IOS_FINAL
//
//  Created by lo pui yi on 25/6/2022.
//

import SwiftUI
import FirebaseAuth
import Firebase
import FirebaseFirestore
import FirebaseFirestoreSwift

struct ProfileView: View {
    @EnvironmentObject  var viewRouter: ViewRouter
    
    var body: some View {
        if let user = Auth.auth().currentUser {
            VStack{
                let name = user.displayName ?? "nil"
                
                Text("Hi, \(name)")
                Text("Your Email is : \(user.email!)")
                Button {
                    do {
                       try Auth.auth().signOut()
                    } catch {
                       print(error)
                    }
                    viewRouter.currentView = "SignInView"
                    
                } label: {
                    Text("LogOut")
                }

                
            }
                        
        }
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView().environmentObject(ViewRouter())
    }
}
