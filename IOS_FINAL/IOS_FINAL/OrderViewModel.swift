//
//  OrderViewModel.swift
//  IOS_FINAL
//
//  Created by lo pui yi on 25/6/2022.
//

import Firebase
import FirebaseFirestore

class OrderViewModel: ObservableObject {
    @Published var orders: [Order] = []
    
    private var db = Firestore.firestore()
    
    init() {
       listenChange()
    }
    
    func modifyOrder(order: Order) {
        do {
          //  try db.collection("ORDERS").document(order.id ?? "").setData(order)
        } catch  {
            print(error)
        }
    }
    
    func listenChange() {
        //.whereField("custId", isEqualTo: Auth.auth().currentUser!.uid)
        //print(Auth.auth().currentUser!.uid)
        db.collection("ORDERS").addSnapshotListener { querySnapshot, error in
            if error != nil {
                print(error!)
                return
            }
            guard let documents = querySnapshot?.documents else {
                print("No documents")
                return
            }
            
            self.orders = documents.map { queryDocumentSnapshot -> Order in
                let data = queryDocumentSnapshot.data()
                
                let address = data["Address"] as? String ?? ""
                let date = data["date"] as? String ?? ""
                let cost = data["cost"] as? Int ?? 0
                let custId = data["custId"] as? String ?? ""
                let paymentMethod = data["paymentMethod"] as? String ?? ""
                let pickupMethod = data["pickupMethod"] as? String ?? ""
                let status = data["status"] as? String ?? ""
                let orderItems = data["orderItems"] as? [OrderItem] ?? []
                //print(queryDocumentSnapshot.documentID)
                return Order(id: queryDocumentSnapshot.documentID, address: address, cost: cost, custId: custId, date: date, orderItems: orderItems, paymentMethod: paymentMethod, pickupMethod: pickupMethod, status: status)
            }
        }
    }
}
