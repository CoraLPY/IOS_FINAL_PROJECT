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
    let Address: String
    let cost: Int
    let custId: String
    let date: String
    let orderItems: [OrderItem]?
    let paymentMethod: String
    let pickupMethod: String
    let status: String
}
