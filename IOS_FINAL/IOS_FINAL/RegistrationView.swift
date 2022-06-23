//
//  RegistrationView.swift
//  IOS_FINAL
//
//  Created by Alvin on 2022/6/23.
//

import SwiftUI

struct RegistrationView: View {
    @State private var name: String = ""
    @State private var email: String = ""
    @State private var phoneNum: String = ""
    @State private var password: String = ""
    @State private var passwordConfirm: String = ""
    
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
                    
                    TextField("name", text: $email)
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
                    Text("Phone Number")
                        .padding(.horizontal)
                    
                    TextField("phone number", text: $phoneNum)
                        .padding(.horizontal)
                    
                    Divider()
                        .padding(.horizontal)
                }
                .padding(.horizontal)
                
                VStack(alignment: .leading) {
                    Text("Password")
                        .padding(.horizontal)
                    
                    TextField("password", text: $password)
                        .padding(.horizontal)
                    
                    Divider()
                        .padding(.horizontal)
                }
                .padding(.horizontal)
                
                VStack(alignment: .leading) {
                    Text("Confirm Password")
                        .padding(.horizontal)
                    
                    TextField("confirm password", text: $passwordConfirm)
                        .padding(.horizontal)
                    
                    Divider()
                        .padding(.horizontal)
                }
                .padding(.horizontal)
                
                Button {
                    
                } label: {
                    Text("Sign In")
                }
                .padding(.top)
            }
        }
    }
}

struct RegistrationView_Previews: PreviewProvider {
    static var previews: some View {
        RegistrationView()
    }
}
