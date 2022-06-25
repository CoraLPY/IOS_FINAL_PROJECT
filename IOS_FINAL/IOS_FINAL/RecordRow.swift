//
//  RecordRow.swift
//  IOS_FINAL
//
//  Created by lo pui yi on 25/6/2022.
//

import SwiftUI

struct RecordRow: View {
    let order: Order
    
    var body: some View {
        HStack{
            VStack{
                Text("\(order.id ?? "orderID")")
                Text("Date: \(order.date)")
                Text("Pickup: \(order.pickupMethod)")
                Text("Total:") + Text("$ \(order.cost)")
                    .foregroundColor(Color.red).italic()
            }
            Spacer()
            
            Text("\(order.status)") .foregroundColor(Color.blue).italic().font(.title)
            
            
        }
        .padding()
        .cornerRadius(20)
        .overlay(
                     RoundedRectangle(cornerRadius: 20)
                        .stroke(Color.ui.OrderBG, lineWidth: 2)
                 )
        .shadow(radius: 30)
    }
}

struct RecordRow_Previews: PreviewProvider {
    static var previews: some View {
        RecordRow(
            order: Order(address: "No. 219-1, Sec. 3, Zhongxiao E. Rd., Da’an Dist., Taipei City 106082, Taiwan (R.O.C.)", cost: 100, custId: "FWywzWzgx6VbwK9rh1IV7zgLhy13", date: "2021-01-05", orderItems:  [
                OrderItem(cost: 10, itemId: "itemId2", quantity: 2),
                OrderItem(cost: 10, itemId: "itemId1", quantity: 1)
             ], paymentMethod: "VISA", pickupMethod: "shipping", status: "progress")
        )
        .previewLayout(.sizeThatFits)
    }
}
