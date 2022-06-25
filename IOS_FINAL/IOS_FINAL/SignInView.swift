//
//  SignInView.swift
//  IOS_FINAL
//
//  Created by Alvin on 2022/6/23.
//

import SwiftUI
import Firebase
import FirebaseAuth

struct SignInView: View {
    @EnvironmentObject  var viewRouter: ViewRouter
    @State private var email: String = ""
    @State private var password: String = ""
    @State var showsignUp = false
    @State var signInProcessing = false
    @State var signInErrorMessage = ""
    @State var isSuccess = false
    
    
    func checkAuth()-> some View{
        if Auth.auth().currentUser != nil {
            self.viewRouter.currentView = "HomeView"
       }
        return  Text("Sign In")
            .font(.system(size: 40))
            .bold()
            .padding(.bottom)
    
    }
    
    var body: some View {
        NavigationView{
        ZStack {
            VStack {
               
                checkAuth()
                VStack(alignment: .leading) {
                    Text("Email")
                        .padding(.horizontal)
//                        .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                    
                    TextField("email", text: $email)
                        .padding(.horizontal)
                    
                    Divider()
                        .padding(.horizontal)
                }
                .padding()
                
                VStack(alignment: .leading) {
                    Text("Password")
                        .padding(.horizontal)
                    
                    SecureField("password", text: $password)
                        .padding(.horizontal)
                    
                    Divider()
                        .padding(.horizontal)
                }
                .padding(.horizontal)
                
                
                    Button {
                        signInUser(userEmail: email, userPassword: password)
                            } label: {
                                    Text("Sign In")
                                }
                            .buttonStyle(.bordered)
                                .buttonBorderShape(.capsule)
                                .disabled(!signInProcessing && !email.isEmpty && !password.isEmpty ? false : true) //disable the “Log In” button if the TextFields are  empty.
                            .padding()
                
                
                
                
                

                HStack {
                    Text("Not register yet?")
                    NavigationLink(isActive: $showsignUp) {
                        RegistrationView()
                    } label: {
                        Button {
                            self.showsignUp = true
                                } label: {
                                    Text("register")
                                        .foregroundColor(Color.blue)
                                        
                                    }
                    }
                    
              
                }
                //show error signin message
                if !signInErrorMessage.isEmpty {
                    Text("Failed creating account: \(signInErrorMessage)")
                        .foregroundColor(.red)
                }
            }
        }
        }
    
    
 
    }
    func signInUser(userEmail: String, userPassword: String) {
        
        signInProcessing = true
        
        Auth.auth().signIn(withEmail: userEmail, password: userPassword) { authResult, error in
            
            guard error == nil else {
                signInProcessing = false
                signInErrorMessage = error!.localizedDescription
                return
            }
            switch authResult {
            case .none:
                print("Could not sign in user.")
                self.signInProcessing = false
            case .some(_):
                print("User signed in")
                self.signInProcessing = false
                //self.isSuccess = true
                self.viewRouter.currentView = "HomeView"
        
            }
        }
    }

}

struct SignInView_Previews: PreviewProvider {
    static var previews: some View {
        SignInView().environmentObject(ViewRouter())
    }
}
