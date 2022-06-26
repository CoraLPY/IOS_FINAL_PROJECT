//
//  OrderBoxView.swift
//  IOS_FINAL
//
//  Created by Alvin on 2022/6/25.
//

import SwiftUI
import FirebaseFirestore
import FirebaseFirestoreSwift

extension Color {
    static let ui = Color.UI()
    
    struct UI {
         let OrderBG = Color("OrderBG")
    }
}

struct OrderBoxView: View {
    let orderItem: OrderItem
    let date: String
    let status: String
    
    var body: some View {
        HStack {
            Spacer()
            
            Image("notes1")
                .resizable()
                .scaledToFit()
                .frame(width: 75, height: 75, alignment: .leading)
            
            Spacer()
            
            VStack(alignment: .leading) {
                Text(orderItem.itemId)
                
                Text("Price:$ \(orderItem.cost)")
                
                Text("Qty: \(orderItem.quantity)")
            }
            
            Spacer()
            
            VStack(alignment: .leading) {
                Text(date)
                
                Text(status)
            }
            .padding(.bottom, 20)
            
            Spacer()
        }
        .frame(minWidth: 0, maxWidth: .infinity)
        .padding(.vertical, 5)
    }
}

struct OrderBoxView_Previews: PreviewProvider {
//    struct OrderBoxViewDemo: View {
//        @FirestoreQuery(collectionPath: "ORDERS") var orders: [Order]
//
//        var body: some View {
//            OrderBoxView(orderItem: orders[0].orderItems![0], date: orders[0].date, status: orders[0].status)
//        }
//    }

    static var previews: some View {
        OrderBoxView(orderItem: OrderItem(itemId:"A80tkdoxWpZNS6FdSW6U",cost: 10, quantity: 1), date: "2021-01-05", status: "shipping")
//        OrderBoxViewDemo()
    }
}
