//
//  CartView.swift
//  IOS_FINAL
//
//  Created by Alvin on 2022/6/24.
//

import SwiftUI
import FirebaseFirestore
import FirebaseFirestoreSwift

struct CartView: View {
    @FirestoreQuery(collectionPath: "CART_ITEMS") var cartItems: [CartItem]
    
    @State var totalItems: Int
    @State var totalPrice: Int
    @State private var paymentMethod: Int = 0
    @State private var pickupMethod: Int = 0
    
    var body: some View {
        ScrollView(.vertical, showsIndicators: true) {
            VStack {
                Text("Total: \(totalItems) item(s)")
                    .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                    .padding(.horizontal, 5)
                
                HStack {
                    Spacer()
                    
                    VStack(alignment: .leading) {
                        ForEach(cartItems) { cartItem in
                            CartItemView(cartItem: cartItem, qty: cartItem.quantity)
                        }
//                        for i in 0..<cartItems.count {
//                            totalItems += cartItems[i].quantity
//                            totalPrice += cartItems[i].getTotalPrice()
//                        }
                    }
                    .padding(.horizontal, 5)
                    .padding(.bottom, 10)
                    .border(Color.black)
                    
                    Spacer()
                }
                
                Text("Total Price: $\(totalPrice)")
                    .frame(minWidth: 0, maxWidth: .infinity, alignment: .trailing)
                    .padding(5)
                
                HStack {
                    Text("Please select payment method: ")
                    
                    Picker("Payment method", selection: $paymentMethod) {
                        Text("Master").tag(0)
                        Text("VISA").tag(1)
                    }
                }
                .padding(.vertical, 10)
                
                HStack {
                    Text("Please select pick-up method: ")
                    
                    Picker("pick-up method", selection: $pickupMethod) {
                        Text("In-store pickup").tag(0)
                        Text("Shipping").tag(1)
                    }
                }
                .padding(.vertical, 10)
                
                Button {
                    // check out
                } label: {
                    Text("Check Out")
                }
                .foregroundColor(.black)
                .padding(3)
                .background(
                    Rectangle()
                        .fill(Color.white)
                        .shadow(color: .black, radius: 2, x: 2, y: 2)
                )
            }
        }
    }
}

struct CartView_Previews: PreviewProvider {
    struct CartViewDemo: View {
        @State var totalItems: Int = 0
        @State var totalPrice: Int = 0
        
        var body: some View {
            CartView(totalItems: totalItems, totalPrice: totalPrice)
        }
    }
    
    static var previews: some View {
        CartViewDemo()
    }
}
