//
//  Order.swift
//  IOS_FINAL
//
//  Created by Alvin on 2022/6/25.
//

import Firebase
import FirebaseFirestoreSwift

class Order: Codable, Identifiable {
    @DocumentID var id: String?
    let address: String
    let cost: Int
    let custId: String
    let date: String
    let orderItems: [OrderItem]
    let paymentMethod: String
    let pickupMethod: String
    let status: String
}
