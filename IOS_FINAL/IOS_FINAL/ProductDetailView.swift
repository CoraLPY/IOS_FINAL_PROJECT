//
//  ProductDetailView.swift
//  IOS_FINAL
//
//  Created by Alvin on 2022/6/23.
//

import SwiftUI
import FirebaseAuth
import FirebaseFirestore
import FirebaseFirestoreSwift

struct ProductDetailView: View {
    let item: Item
    
    private let db = Firestore.firestore()
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
                        if purchaseAmount > 0 && purchaseAmount <= item.remainingStock {
                            do {
                                let cartItem = CartItem(custID: Auth.auth().currentUser!.uid, image: item.image, itemID: item.name, price: item.price, quantity: purchaseAmount)
                                let docID = try db.collection("CART_ITEMS").addDocument(from: cartItem)
                                print(docID)
                                try db.collection("ITEMS").document(item.id ?? "").setData(from: Item(category: item.category, comments: item.comments, description: item.description, image: item.image, name: item.name, price: item.price, remainingStock: item.remainingStock - purchaseAmount))
                            } catch {
                                print(error)
                            }
                        }
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
        ProductDetailView(item: Item(id: "z0ak2LDumWLrCxmBExtS", category: "NOTES", comments: [
            Comment(date: "2022-02-29", description: "A little bit update", rate: 1, userName: "Mary"),
            Comment(date: "2022-02-29", description: "", rate: 5, userName: "Mary"),
            Comment(date: "2022-02-29", description: "Good", rate: 5, userName: "Mary"),
            Comment(date: "2022-02-29", description: "Wonderful", rate: 5, userName: "Mary")
        ], description: "Classic design,Perfect for messages,Greener choice", image: "notes1", name: "Post-it 654 Yellow Notes 3 inch x 3 inch", price: 20, remainingStock: 40))
    }
}
