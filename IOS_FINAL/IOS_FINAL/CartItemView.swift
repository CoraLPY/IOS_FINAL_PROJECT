//
//  CartItemView.swift
//  IOS_FINAL
//
//  Created by Alvin on 2022/6/24.
//

import SwiftUI
import Firebase
import FirebaseFirestore

struct CartItemView: View {
    var cartItem: CartItem
    
    private let store = Firestore.firestore()
    private let imageName: String = "notes1"
    
    @State var qty: Int
    
    var body: some View {
        HStack {
            VStack {
                Image(imageName)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 75, height: 75)
            }
            
            VStack(alignment: .leading) {
                Text("\(cartItem.itemID)")
                
                Text("Price: \(cartItem.price)")
                
                Text("Qty: \(qty)")
            }
            
            VStack(alignment: .trailing) {
                Stepper("") {
                    if qty < cartItem.quantity {
                        qty += 1
                    }
                } onDecrement: {
                    if qty > 1 {
                        qty -= 1
                    }
                }
                
                HStack {
                    Button {
                        do {
                            try store.collection("CART_ITEMS").document(cartItem.id ?? "").setData(from: CartItem(custID: cartItem.custID, itemID: cartItem.itemID, price: cartItem.price, quantity: qty))
                        } catch {
                            print(error)
                        }
                    } label: {
                        Text("Update")
                            .foregroundColor(.black)
                            .padding(3)
                            .background(
                                RoundedRectangle(cornerRadius: 10)
                                    .fill(Color.white)
                                    .shadow(color: .black, radius: 2, x: 2, y: 2)
                            )
                    }
                    
                    Button {
                        store.collection("CART_ITEMS").document(cartItem.id ?? "").delete()
                    } label: {
                        Text("Delete")
                            .foregroundColor(.black)
                            .padding(3)
                            .background(
                                RoundedRectangle(cornerRadius: 10)
                                    .fill(Color.white)
                                    .shadow(color: .black, radius: 2, x: 2, y: 2)
                            )
                    }
                }
            }
        }
    }
}

struct CartItemView_Previews: PreviewProvider {
    struct CartItemViewDemo: View {
        @State var totalItems: Int = 0
        @State var totalPrice: Int = 0
        
        var body: some View {
            CartItemView(cartItem: CartItem(custID: "tI9qKKyj2vU24Twws6zgaYIvPTx1", itemID: "item4", price: 7, quantity: 10), qty: 10)
        }
    }
    
    static var previews: some View {
        CartItemViewDemo()
    }
}
