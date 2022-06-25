//
//  OrderView.swift
//  IOS_FINAL
//
//  Created by Alvin on 2022/6/25.
//

import SwiftUI
import FirebaseFirestore
import FirebaseFirestoreSwift

struct OrderView: View {
    @State var orders = [Order]()
    private var db = Firestore.firestore()
    
    init() {
        db.collection("ORDERS").getDocuments { [self] (snap, err) in
            if err != nil{
                print(err!)
                print((err?.localizedDescription)!)
                return
            }

            for i in snap!.documents{
                let id = i.documentID
                let Address = i.get("Address") as! String
                let cost = i.get("cost") as! Int
                let custId = i.get("custId") as! String
                let date = i.get("date") as! String
                let orderItems = i.get("orderItems") as? [OrderItem] ?? []
                let paymentMethod = i.get("paymentMethod") as! String
                let pickupMethod = i.get("pickupMethod") as! String
                let status = i.get("status") as! String
                
                self.orders.append(Order(id: id, Address: Address, cost: cost, custId: custId, date: date, orderItems: orderItems, paymentMethod: paymentMethod, pickupMethod: pickupMethod, status: status))
            }
        }
    }
    
    var body: some View {
        let _ = print("orders = \(orders)")
        List {
            ForEach(orders) { order in
                let _ = print("order = \(order)")
                OrderBoxView(orderItem: order.orderItems?[0] ?? [OrderItem]()[0], date: order.date, status: order.status)
            }
        }
    }
}

struct OrderView_Previews: PreviewProvider {
    static var previews: some View {
        OrderView()
    }
}
