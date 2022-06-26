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
    
    func getOrderItems(completionHandler:@escaping([OrderItem])->()) {
        var orderItems = [OrderItem]()
        for cartItem in cartItems {
            var id: String = ""
            db.collection("ITEMS").whereField("name", isEqualTo: cartItem.itemID).getDocuments { querySnapshot, err in
                if let err = err {
                    print(err)
                }
                guard let docs = querySnapshot?.documents else { return }
                for doc in docs {
                    let name = doc.get("name") as! String
                    if name != cartItem.itemID {
                        continue
                    }
                    print("name=\(name)")
                    id = doc.documentID
                    print("inside id=\(id)")
                    orderItems.append(OrderItem(itemId: id, cost: cartItem.price, quantity: cartItem.quantity))
                    print(orderItems)
                }
                ////////////////////////////////
                ///// DONT TOUCH//
                ////////////////////////////////
                // voodoo programming
                completionHandler(orderItems)
                // what even are you?
            }
        }
        // or this will work someday?
        //completionHandler(orderItems)
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
                var user = Auth.auth().currentUser
                var uid = user?.uid ?? "nil"
                
                return doc.data()["custID"] as! String == uid
            }
            
            self.totalPrice = 0
            self.totalItems = 0
            
            self.cartItems = filterdDocuments.map { queryDocumentSnapshot -> CartItem in
                let data = queryDocumentSnapshot.data()
                
                let custID = data["custID"] as? String ?? ""
                let image = data["image"] as? String ?? ""
                let itemID = data["itemID"] as? String ?? ""
                let price = data["price"] as? Int ?? 0
                let quantity = data["quantity"] as? Int ?? 0
                
                self.totalPrice += price * quantity
                self.totalItems += quantity
                
                return CartItem(id: queryDocumentSnapshot.documentID, custID: custID, image: image, itemID: itemID, price: price, quantity: quantity)
            }
        }
    }
}
