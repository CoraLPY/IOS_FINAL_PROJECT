//
//  SearchItemView.swift
//  IOS_FINAL
//
//  Created by lo pui yi on 24/6/2022.
//

import SwiftUI
import Firebase
import FirebaseFirestore
import FirebaseFirestoreSwift
import FirebaseAuth

extension String: Identifiable {
    public var id: String { self }
}


struct SearchItemView: View {
    
    let categories = ["ALL", "LABELS", "NOTES", "WRITING","OTHERS"]
    
    @Binding var keyword: String
    @State private var isEditing = false
    @State private var isSearch = false
    @ObservedObject var data = itemViewModel()
    //@State private var selectCategory = Category.ALL
    @Binding var selectedCategory: String

    


    var body: some View {
       
       // NavigationView {
        ScrollView{
            VStack{
                searchBar
                
                
                //category picker
                Picker(selection: $selectedCategory) {
                                ForEach(categories) { category in
                                    Text(category)
                                }
                            } label: {
                                Text("select Category")
                            }
                            .pickerStyle(.segmented)
                       
              
    
                // item grid
                let itemColumns = Array(repeating: GridItem(), count: 2)
                LazyVGrid(columns: itemColumns) {
                    ForEach(self.data.items.filter{(self.keyword.isEmpty ? true : $0.name.localizedCaseInsensitiveContains(self.keyword))&&(self.selectedCategory == "ALL" ? true : $0.category.localizedStandardContains(self.selectedCategory))}, id: \.id) { item in
                       NavigationLink {
                           Text(item.id ?? "null")
                           
                      } label: {
                          ProductBoxView(imageName: item.image, itemName: item.name, price: Int(item.price) ?? 0 , qty: Int(item.remainingStock) ?? 0)
                      }
                        
                    }
                }
         
            }
            
        }
        //}
    }
    var searchBar: some View{
        HStack {

                    TextField("Search ...", text: $keyword)
                        .padding(7)
                        .padding(.horizontal, 25)
                        .background(Color(.systemGray6))
                        .cornerRadius(8)

                        .onSubmit{
                            print(keyword)
                            isSearch = true
                            
                            
                        }
                        .submitLabel(.done)
            
                        .overlay(
                            HStack {
                                Image(systemName: "magnifyingglass")
                                    .foregroundColor(.gray)
                                    .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                                    .padding(.leading, 8)

                                if isEditing {
                                    Button(action: {
                                        self.keyword = ""
                                    }) {
                                        Image(systemName: "multiply.circle.fill")
                                            .foregroundColor(.gray)
                                            .padding(.trailing, 8)
                                    }
                                }
                            }
                        )
                        .padding(.horizontal, 10)
                        .onTapGesture {
                            self.isEditing = true
                        }

                    if isEditing {
                        Button(action: {
                            self.isEditing = false
                            self.keyword = ""
                            UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)

                        }) {
                            Text("Cancel")
                        }
                        .padding(.trailing, 10)
                        .transition(.move(edge: .trailing))
                        .animation(.default)
                    }
                }
    }
    

    
}

struct SearchItemView_Previews: PreviewProvider {
    static var previews: some View {
        SearchItemView(keyword:.constant("key"), selectedCategory: .constant("ALL"))
    }
}
