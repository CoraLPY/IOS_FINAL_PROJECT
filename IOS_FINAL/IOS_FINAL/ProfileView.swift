//
//  ProfileView.swift
//  IOS_FINAL
//
//  Created by lo pui yi on 25/6/2022.
//

import SwiftUI
import Firebase
import FirebaseAuth
import FirebaseFirestore
import FirebaseFirestoreSwift

struct ProfileView: View {
    @EnvironmentObject  var viewRouter: ViewRouter
    @State  var name: String = ""
    @State var isEdit = false

    var body: some View {
        if let user = Auth.auth().currentUser {
            //let name = user.displayName ?? "nil"
            
            VStack(alignment: .center,spacing: 20) {
                
                Text("My Profile").font(.largeTitle)
                
                
                Image("profile_icon")
                                    .resizable()
                                    .scaledToFill()
                                    .frame(width: 200, height: 200)
                                    .clipShape(Circle())
                                    .padding(20)
                
                
                HStack{
                    Text("Email:")
                        .padding(.horizontal)
                    Spacer()
                    Text("\(user.email!)")
                        .padding(.horizontal)
                    
                }
                HStack() {
                                  Text("Name")
                                      .padding(.horizontal)
                                  Spacer()
                                  TextField("name", text: $name)
                                    .textFieldStyle(.roundedBorder)
                                    .padding()
                       
                              }
                
                                   
                                   Button {
                                       changeUserName(_name: name)
                                       UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
                                           } label: {
                                               Text("Change Name")
                                                   .font(.system(size: 15))
                                                   .padding()
                                           }
                                           .buttonStyle(.bordered)
                                           .buttonBorderShape(.capsule)
                                           .disabled(!name.isEmpty ? false : true)
                
                Button {
                    do {
                       try Auth.auth().signOut()
                    } catch {
                       print(error)
                    }
                    viewRouter.currentView = "SignInView"
                } label: {
                    Text("LogOut")
                        .foregroundColor(Color.red)
                        .frame(minWidth: 300, maxWidth: .infinity)
                        .padding(20)
                        .border(Color.red, width: 3)
                       .aspectRatio(16.0 / 9.0, contentMode: .fit)
                }.padding(30)


                                 
            }
            .alert("NOTICED", isPresented: $isEdit, actions: {
                Button("OK") { }
            }, message: {
                Text(" Change Name Successfully")
            })
            
            .onAppear(){
                var user = Auth.auth().currentUser
                var _name = user?.displayName ?? "nil"
                self.name = _name
                
            }

        }
        }
    
    
    func changeUserName(_name: String) {
           
                /////set name
                    let changeRequest = Auth.auth().currentUser?.createProfileChangeRequest()
                changeRequest?.displayName = _name
                changeRequest?.commitChanges(completion: { error in
                   guard error == nil else {
                       print(error?.localizedDescription)
                       isEdit = false
                       return
                   }
                    print("change name successfully")
                    isEdit = true
                    
                                    
                })
                }
    

        
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView().environmentObject(ViewRouter())
    }
}
