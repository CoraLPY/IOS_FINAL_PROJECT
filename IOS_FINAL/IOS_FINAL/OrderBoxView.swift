//
//  OrderBoxView.swift
//  IOS_FINAL
//
//  Created by Alvin on 2022/6/25.
//

import SwiftUI

extension Color {
    static let ui = Color.UI()
    
    struct UI {
         let OrderBG = Color("OrderBG")
    }
}

struct OrderBoxView: View {
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

struct OrderBoxView_Previews: PreviewProvider {
    static var previews: some View {
        OrderBoxView(
            order: Order(address: "No. 219-1, Sec. 3, Zhongxiao E. Rd., Da’an Dist., Taipei City 106082, Taiwan (R.O.C.)", cost: 100, custId: "FWywzWzgx6VbwK9rh1IV7zgLhy13", date: "2021-01-05", orderItems:  [
                OrderItem(cost: 10, quantity: 2),
                OrderItem(cost: 10, quantity: 1)
             ], paymentMethod: "VISA", pickupMethod: "shipping", status: "progress")
        )
        .previewLayout(.sizeThatFits)
    }
}
