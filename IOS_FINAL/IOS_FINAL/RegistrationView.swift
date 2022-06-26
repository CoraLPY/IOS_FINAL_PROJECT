//
//  RegistrationView.swift
//  IOS_FINAL
//
//  Created by Alvin on 2022/6/23.
//

import SwiftUI
import Firebase
import FirebaseAuth

struct RegistrationView: View {
    @EnvironmentObject  var viewRouter: ViewRouter
    @State private var name: String = ""
    @State private var email: String = ""
    @State private var password: String = ""
    @State private var passwordConfirm: String = ""
    @State var signUpProcessing = false
    @State var isSuccess = false
    
    var body: some View {
        ZStack {
            VStack {
                Text("Registration")
                    .font(.system(size: 40))
                    .bold()
                    .padding(.bottom)
                
                VStack(alignment: .leading) {
                    Text("Name")
                        .padding(.horizontal)
                    
                    TextField("name", text: $name)
                        .padding(.horizontal)
                    
                    Divider()
                        .padding(.horizontal)
                }
                .padding()
                
                VStack(alignment: .leading) {
                    Text("Email")
                        .padding(.horizontal)
                    
                    TextField("email", text: $email)
                        .padding(.horizontal)
                    
                    Divider()
                        .padding(.horizontal)
                }
                .padding(.horizontal)
                

                
                VStack(alignment: .leading) {
                    Text("Password")
                        .padding(.horizontal)
                    
                    SecureField("password", text: $password)
                        .padding(.horizontal)
                    
                    Divider()
                        .padding(.horizontal)
                }
                .padding(.horizontal)
                
                VStack(alignment: .leading) {
                    Text("Confirm Password")
                        .padding(.horizontal)
                    
                    SecureField("confirm password", text: $passwordConfirm)
                        .padding(.horizontal)
                    
                    Divider()
                        .padding(.horizontal)
                }
                .padding(.horizontal)

                
              /*  NavigationLink(isActive: $isSuccess) {
                    HomeView()
                } label: {*/
                    Button {
                        signUpUser(userEmail: email, userPassword: password)
                            } label: {
                                Text("Sign In")
                            }
                            .buttonStyle(.bordered)
                            .buttonBorderShape(.capsule)
                            .disabled(!signUpProcessing && !email.isEmpty && !password.isEmpty && !name.isEmpty && !passwordConfirm.isEmpty && password == passwordConfirm ? false : true)
                            .padding(.top)
               // }
                
              
                
                
            }
        }
    }
    func signUpUser(userEmail: String, userPassword: String) {
           
           signUpProcessing = true
        Auth.auth().createUser(withEmail: userEmail, password: userPassword){result, error in
            
            guard let user = result?.user,
                  error == nil else {
                signUpProcessing = false
                print(error?.localizedDescription)
                return
            }
            print(user.email, user.uid)
        
            
            switch result {
                case .none:
                    print("Could not create account.")
                    signUpProcessing = false
                case .some(_):
                    print("User created")
                    signUpProcessing = false
            
                   // isSuccess = true
                    
                /////set name
                    let changeRequest = Auth.auth().currentUser?.createProfileChangeRequest()
                changeRequest?.displayName = name
                changeRequest?.commitChanges(completion: { error in
                   guard error == nil else {
                       print(error?.localizedDescription)
                       return
                   }
                    self.viewRouter.currentView = "SignInView"
                                    
                })
                }
            
            
        }
       }
    
}

struct RegistrationView_Previews: PreviewProvider {
    static var previews: some View {
        RegistrationView().environmentObject(ViewRouter())
    }
}
