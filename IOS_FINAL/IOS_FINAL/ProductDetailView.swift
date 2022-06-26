//
//  ProductDetailView.swift
//  IOS_FINAL
//
//  Created by Alvin on 2022/6/23.
//

import SwiftUI
import FirebaseFirestore
import FirebaseFirestoreSwift

struct ProductDetailView: View {
    let item: Item
    
    @State private var purchaseAmount: Int = 1
    
    var body: some View {
        ScrollView(.vertical, showsIndicators: true) {
            VStack(alignment: .leading) {
                Image(item.image)
                    .resizable()
                    .scaledToFit()
                    .frame(width: .infinity, height: .infinity)
                
                HStack {
                    Stepper("Add    \(purchaseAmount)    to cart: ") {
                        if purchaseAmount < item.remainingStock {
                            purchaseAmount += 1
                        }
                    } onDecrement: {
                        if purchaseAmount > 1 {
                            purchaseAmount -= 1
                        }
                    }
                    
                    Button {
                        
                    } label: {
                        Image(systemName: "cart.badge.plus")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 40, height: 40)
                    }
                }
                .padding(.horizontal, 10)
                
                Text("Item detail")
                    .padding(.leading, 10)
                
                HStack {
                    Spacer()
                    
                    VStack(alignment: .leading) {
                        Text("Name: \(item.name)")

                        Text("Price: \(item.price)")

                        Text("Remaining stock: \(item.remainingStock)")

                        Text(item.description)
                    }
                    .padding(5)
                    .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity)
                    .border(Color.black)
                    
                    Spacer()
                }
                
                Text("Comment")
                    .padding(.leading, 10)
                
                HStack {
                    Spacer()
                    
                    VStack(alignment: .leading) {
                        ForEach(item.comments ?? []) { comment in
                            CommentView(comment: comment)
                        }
                    }
                    .padding(.bottom, 10)
                    .border(Color.black)
                    
                    Spacer()
                }
            }
        }
    }
}

struct ProductDetailView_Previews: PreviewProvider {
    static var previews: some View {
        ProductDetailView(item: Item(category: "NOTES", comments: [
            Comment(date: "2022-02-29", description: "A little bit update", rate: 1, userName: "Mary"),
            Comment(date: "2022-02-29", description: "", rate: 5, userName: "Mary"),
            Comment(date: "2022-02-29", description: "Good", rate: 5, userName: "Mary"),
            Comment(date: "2022-02-29", description: "Wonderful", rate: 5, userName: "Mary")
        ], description: "Prof sticky notes", image: "notes1", name: "Yellow Sticky notes", price: 10, remainingStock: 30))
    }
}
