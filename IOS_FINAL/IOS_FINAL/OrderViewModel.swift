//
//  OrderViewModel.swift
//  IOS_FINAL
//
//  Created by lo pui yi on 25/6/2022.
//

import Firebase
import FirebaseFirestore

class OrderViewModel: ObservableObject {

    @Published var orders :[Order] = []
   // @Published var orderitems :[OrderItem] = []

    private var db = Firestore.firestore()
    
    init() {
       listenChange()
    }
    

    func modifyOrder(order: Order) {
        do {
       
            try db.collection("ORDERS").document(order.id ?? "").setData(["status":"cancel"],merge: true)
        } catch  {
            print(error)
        }
    }
    
    func listenChange() {

        var user = Auth.auth().currentUser
        var uid = user?.uid ?? "nil"
        //Auth.auth().currentUser!.uid ?? ""
        db.collection("ORDERS").whereField("custId", isEqualTo: uid).addSnapshotListener { querySnapshot, error in
            if error != nil{
            print(error!)

                return
            }
            guard let documents = querySnapshot?.documents else {
                print("No documents")
                return
            }
            
            self.orders = documents.map{ queryDocumentSnapshot -> Order in

                
                let data = queryDocumentSnapshot.data()
                let id = queryDocumentSnapshot.documentID
                let address = data["Address"] as? String ?? ""
                let date = data["date"] as? String ?? ""
                let cost = data["cost"] as? Int ?? 0
                let custId = data["custId"] as? String ?? ""
                let paymentMethod = data["paymentMethod"] as? String ?? ""
                let pickupMethod = data["pickupMethod"] as? String ?? ""
                let status = data["status"] as? String ?? ""   
                let orderItems = data["orderItems"] as? NSArray
                var curr_orderitems :[OrderItem] = []
                for orderitem in orderItems as! [Dictionary<String, AnyObject>] {
                                              var curr_item = OrderItem(id: "", itemId: "", cost: 0, quantity: 0)
                                            curr_item.id =  orderitem.description.id
                                              if let itemId = orderitem["itemId"] as? String {
                                                  curr_item.itemId = itemId
                                              }
                                              if let cost = orderitem["cost"] as? Int {
                                                  curr_item.cost = cost
                                              }
                                              if let quantity = orderitem["quantity"] as? Int {
                                                  curr_item.quantity = quantity
                                              }
                                            //print("orderid-\(queryDocumentSnapshot.documentID) : \(orderitem["itemId"])")
                                            curr_orderitems.append(curr_item)
                                          }
                
                return Order(id: id, address: address, cost: cost, custId: custId, date: date, orderItems: curr_orderitems, paymentMethod: paymentMethod, pickupMethod: pickupMethod, status: status)
        
            }
        }
 
                
    }
}
