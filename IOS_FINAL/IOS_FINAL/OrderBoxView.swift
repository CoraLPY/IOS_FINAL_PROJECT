//
//  OrderBoxView.swift
//  IOS_FINAL
//
//  Created by Alvin on 2022/6/25.
//

import SwiftUI

struct OrderBoxView: View {
    let order: Order
    
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}

struct OrderBoxView_Previews: PreviewProvider {
    static var previews: some View {
        OrderBoxView(
            order: Order(address: "No. 219-1, Sec. 3, Zhongxiao E. Rd., Da’an Dist., Taipei City 106082, Taiwan (R.O.C.)",
             cost: 25,
             custId: "FWywzWzgx6VbwK9rh1IV7zgLhy13",
             date: "2021-01-05",
             orderItems: [
                OrderItem(cost: 10, quantity: 2),
                OrderItem(cost: 10, quantity: 1)
             ],
             paymentMethod: "VISA",
             pickupMethod: "shipping",
             status: "progress")
        )
    }
}
