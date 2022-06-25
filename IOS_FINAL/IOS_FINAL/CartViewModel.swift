//
//  CartViewModel.swift
//  IOS_FINAL
//
//  Created by Alvin on 2022/6/25.
//

import Firebase
import FirebaseFirestore

class CartViewModel: ObservableObject {
    @Published var cartItems: [CartItem] = []
    @Published var totalItems: Int = 0
    @Published var totalPrice: Int = 0
    
    private var db = Firestore.firestore()
    
    init() {
       listenChange()
    }
    
    func getOrderItems() -> [OrderItem] {
        var orderItems = [OrderItem]()
        for cartItem in cartItems {
            orderItems.append(OrderItem(cost: cartItem.price, itemId: cartItem.itemID, quantity: cartItem.quantity))
        }
        return orderItems
    }
    
    func listenChange() {
        db.collection("CART_ITEMS").addSnapshotListener { querySnapshot, error in
            if error != nil {
                print(error!)
                return
            }
            guard let documents = querySnapshot?.documents else {
                print("No documents")
                return
            }
            
            let filterdDocuments = documents.filter { doc in
                return doc.data()["custID"] as! String == Auth.auth().currentUser!.uid
            }
            
            self.totalPrice = 0
            self.totalItems = 0
            
            self.cartItems = filterdDocuments.map { queryDocumentSnapshot -> CartItem in
                let data = queryDocumentSnapshot.data()
                
                let custID = data["custID"] as? String ?? ""
                let itemID = data["itemID"] as? String ?? ""
                let price = data["price"] as? Int ?? 0
                let quantity = data["quantity"] as? Int ?? 0
                
                self.totalPrice += price * quantity
                self.totalItems += quantity
                
                return CartItem(id: queryDocumentSnapshot.documentID, custID: custID, itemID: itemID, price: price, quantity: quantity)
            }
        }
    }
}
