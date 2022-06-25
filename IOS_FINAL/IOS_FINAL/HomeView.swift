//
//  HomeView.swift
//  IOS_FINAL
//
//  Created by lo pui yi on 24/6/2022.
//

import SwiftUI
import Firebase
import FirebaseFirestore
import FirebaseFirestoreSwift
import FirebaseAuth

struct HomeView: View {
    @State var index = 0
    var bannerImages = ["promotion1", "promotion2", "promotion3"]
    let category = [
       "ALL",
       "LABELS",
       "NOTES",
       "WRITING",
       "OTHERS"
   ]
    
    @FirestoreQuery(collectionPath: "ITEMS", predicates: [.order(by: "name", descending: true),.limitTo(6)])
    fileprivate var itemResults:Result<[Item], Error>
    

    @State private var keyword: String = ""
    @State private var selectedCategory: String = "ALL"
    
    @State private var isEditing = false
    
    @State var isSearch = false
    @State var isCategory = false

    
    var body: some View {
        TabView{
            homePage
                .tabItem{
                  Label("Home",systemImage: "house.fill")
                }
            CartView(totalItems: 0, totalPrice: 0)
                .tabItem{
                  Label("Cart",systemImage: "cart.fill")
                }
            Text("Order")
                .tabItem{
                  Label("Order",systemImage: "list.bullet.rectangle.fill")
                }
            Text("Profile")
                .tabItem{
                  Label("Profile",systemImage: "person.crop.circle.fill")
                }
        }
    }
    
    var banner: some View {
        VStack(spacing: 20) {
            PagingView(index: $index.animation(), maxIndex: bannerImages.count - 1) {
              ForEach(self.bannerImages, id: \.self) { imageName in
                  Image(imageName)
                      .resizable()
                      .scaledToFill()
              }
            }
            .aspectRatio(3/2, contentMode: .fit)
            .clipShape(RoundedRectangle(cornerRadius: 15))
        }
        .padding()
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
                            Button {
                                self.keyword = ""
                                self.isEditing = false
                                //UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
                            } label: {
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
                NavigationLink(destination: SearchItemView(keyword: $keyword, selectedCategory: $selectedCategory), isActive: $isSearch) {
                    Image(systemName: "paperplane")
                        .foregroundColor(.gray)
                        .padding(.trailing, 10)
                        .transition(.move(edge: .trailing))
                        .animation(.default)
                }
            }
        }
    }
    
    
    var homePage: some View {
        NavigationView {
            ScrollView {
                VStack {
                    searchBar
                    banner
                    //category button
                    let columns = Array(repeating: GridItem(spacing: 0), count: 4)
                    LazyVGrid(columns: columns) {
                        ForEach(category.indices, id: \.self) { item in
                          NavigationLink(isActive: $isCategory) {
                              SearchItemView(keyword: $keyword, selectedCategory: $selectedCategory)
                        } label: {
                            Button {
                                selectedCategory = category[item]
                                //print(selectedCategory)
                                isCategory = true
                            } label: {
                                CategoryView(category: category[item])
                            }
                        }
                        }
                    }
                    
                    //random recommended products
                    Text("RECOMMENDED PRODUCTS:")
                        .foregroundColor(Color.blue)
                    
                    if case let .success(items) = itemResults {
                        let itemColumns = Array(repeating: GridItem(), count: 2)
                        LazyVGrid(columns: itemColumns) {
                            ForEach(items) { item in
                               NavigationLink {
                                   ProductDetailView(item: item)
                               } label: {
                                   ProductBoxView(item: item)
                               }
                            }
                        }
                    } else if case let .failure(error) = itemResults {
                        // Handle error
                        let _ = print(error)
                        Text("Couldn't map data: \(error.localizedDescription)")
                    }
                    
                    Spacer()
                }
            }
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
