//
//  CartView.swift
//  IOS_FINAL
//
//  Created by Alvin on 2022/6/24.
//

import SwiftUI
import FirebaseAuth
import FirebaseFirestore
import FirebaseFirestoreSwift

struct CartView: View {
    @ObservedObject var cartViewModel = CartViewModel()
    
    private let db = Firestore.firestore()
    
    @State private var paymentMethod: Int = 0
    @State private var pickupMethod: Int = 0
    
    var body: some View {
        ScrollView(.vertical, showsIndicators: true) {
            VStack {
                Text("Total: \(cartViewModel.totalItems) item(s)")
                    .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                    .padding(.horizontal, 5)
                
                HStack {
                    Spacer()
                    
                    VStack(alignment: .leading) {
                        ForEach(cartViewModel.cartItems) { cartItem in
                            CartItemView(cartItem: cartItem, qty: cartItem.quantity)
                        }
                    }
                    .padding(.horizontal, 5)
                    .padding(.bottom, 10)
                    .border(Color.black)
                    
                    Spacer()
                }
                
                Text("Total Price: $\(cartViewModel.totalPrice)")
                    .frame(minWidth: 0, maxWidth: .infinity, alignment: .trailing)
                    .padding(5)
                
                HStack {
                    Text("payment method: ")
                    
                    Picker("Payment method", selection: $paymentMethod) {
                        Text("Master").tag(0)
                        Text("VISA").tag(1)
                    }
                    .pickerStyle(.segmented)
                }
                .padding(10)
                
                HStack {
                    Text("pick-up method: ")
                    
                    Picker("pick-up method", selection: $pickupMethod) {
                        Text("In-store pickup").tag(0)
                        Text("Shipping").tag(1)
                    }
                    .pickerStyle(.segmented)
                }
                .padding(10)
                
                Button {
                    if let user = Auth.auth().currentUser {
                        let addr = "No. 219-1, Sec. 3, Zhongxiao E. Rd., Da’an Dist., Taipei City 106082, Taiwan (R.O.C.)"
//                        let date = Date.now.formatted(date: ., time: .omitted)
                        let dateFormatter = DateFormatter()
                        dateFormatter.dateFormat = "yyyy-MM-dd"
                        let date = dateFormatter.string(from: Date.now)
                        let payment = paymentMethod == 0 ? "Master" : "VISA"
                        let pickup = pickupMethod == 0 ? "in-store pickup" : "Shipping"
                        
//                        let order = Order(address: addr, cost: cartViewModel.totalPrice, custId: user.uid, date: date, orderItems: cartViewModel.getOrderItems(), paymentMethod: payment, pickupMethod: pickup, status: "progress")
                        
                        
                        cartViewModel.getOrderItems { orderItems in
                            
                            print("outside items:\(orderItems)")
                            let order = Order(address: addr, cost: cartViewModel.totalPrice, custId: user.uid, date: date, orderItems: orderItems, paymentMethod: payment, pickupMethod: pickup, status: "progress")
                            
                            
                            
                            do {
                                let docID = try db.collection("ORDERS").addDocument(from: order)
                                print(docID)
                                
                                for cartItem in cartViewModel.cartItems {
                                    db.collection("CART_ITEMS").document(cartItem.id ?? "").delete()
                                }
                            } catch {
                                print(error)
                            }
                        }
                        
//                        do {
//                            let docID = try db.collection("ORDERS").addDocument(from: order)
//                            print(docID)
//
//                            for cartItem in cartViewModel.cartItems {
//                                db.collection("CART_ITEMS").document(cartItem.id ?? "").delete()
//                            }
//                        } catch {
//                            print(error)
//                        }
                    }
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
    static var previews: some View {
        CartView()
    }
}
