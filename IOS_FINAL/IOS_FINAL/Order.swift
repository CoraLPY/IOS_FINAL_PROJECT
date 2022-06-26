//
//  Order.swift
//  IOS_FINAL
//
//  Created by Alvin on 2022/6/25.
//
import Foundation
import FirebaseFirestoreSwift

struct Order: Codable, Identifiable, Equatable {
    @DocumentID var id: String?
    //var id: String = UUID().uuidString
    var address: String
    var cost: Int
    var custId: String
    var date: String
    var orderItems: [OrderItem]?
    var paymentMethod: String
    var pickupMethod: String
    var status: String
}

/*let order = Order(address: "No. 219-1, Sec. 3, Zhongxiao E. Rd., Da’an Dist., Taipei City 106082, Taiwan (R.O.C.)", cost: 100, custId: "FWywzWzgx6VbwK9rh1IV7zgLhy13", date: "2021-01-05", orderItems:  [
    OrderItem(cost: 10, quantity: 2),
    OrderItem(cost: 10, quantity: 1)
 ], paymentMethod: "VISA", pickupMethod: "shipping", status: "progress")*/
