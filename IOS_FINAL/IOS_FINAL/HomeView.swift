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
    
    //@FirestoreQuery(collectionPath: "ITEMS", predicates: [.order(by: "name", descending: true)])
    
    @FirestoreQuery(collectionPath: "CART_ITEMS", predicates: [.order(by: "CustID", descending: true)])
   // fileprivate var itemResults:Result<[Item], Error>
    fileprivate var cartItemResults:Result<[CartItem], Error>
    
    var body: some View {
        TabView{
                homePage
                .tabItem{
                  Label("Home",systemImage: "house.fill")
                }
            Text("Cart")
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
    
    var homePage: some View {
        NavigationView {
        ScrollView{
            VStack{
                banner
                //category button
                let columns = Array(repeating: GridItem(spacing: 0), count: 4)
                LazyVGrid(columns: columns) {
                    ForEach(category.indices, id: \.self) { item in
                      NavigationLink {
                            Image(category[item])
                                .resizable()
                                .scaledToFit()
                      } label: {
                        CategoryView(category: category[item])
                      }
                    }
                }
                //random recommended products
                Text("RECOMMENDED PRODUCTS:")
                    .foregroundColor(Color.blue)
                
                if case let .success(items) = cartItemResults {
                    let itemColumns = Array(repeating: GridItem(), count: 2)
                    LazyVGrid(columns: itemColumns) {
                        ForEach(items) { item in
                            NavigationLink {
                                Text(item.custID)
                            } label: {
                              Text(item.custID)
                             /* ProductBoxView(imageName: item.image, itemName: item.name, price: Int(item.price) ?? 0 , qty: Int(item.remainingStock) ?? 0)*/
                            }
                        }
                    }
                } else if case let .failure(error) = cartItemResults {
                    // Handle error
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
