//
//  SignInView.swift
//  IOS_FINAL
//
//  Created by Alvin on 2022/6/23.
//

import SwiftUI

struct SignInView: View {
    @State private var email: String = ""
    @State private var password: String = ""
    
    
    var body: some View {
        ZStack {
            VStack {
                Text("Sign In")
                    .font(.system(size: 40))
                    .bold()
                    .padding(.bottom)
                
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
                    
                    TextField("password", text: $password)
                        .padding(.horizontal)
                    
                    Divider()
                        .padding(.horizontal)
                }
                .padding(.horizontal)
                
                Button {
                    
                } label: {
                    Text("Sign In")
                }
                .padding()

                HStack {
                    Text("Not register yet?")
                    
                    Button {
                        
                    } label: {
                        Text("register")
                    }
                }
            }
        }
    }
}

struct SignInView_Previews: PreviewProvider {
    static var previews: some View {
        SignInView()
    }
}
