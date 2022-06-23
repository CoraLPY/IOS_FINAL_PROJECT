//
//  HomeView.swift
//  IOS_FINAL
//
//  Created by lo pui yi on 24/6/2022.
//

import SwiftUI

struct HomeView: View {
    @State var index = 0
    var bannerImages = ["promotion1", "promotion2", "promotion3"]
    
    var body: some View {
        TabView{
            banner
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
    
    var banner: some View{
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
    
}



struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
