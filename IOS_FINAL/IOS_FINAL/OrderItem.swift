//
//  OrderItem.swift
//  IOS_FINAL
//
//  Created by Alvin on 2022/6/25.
//

import Foundation

class OrderItem: Codable, Identifiable {
    var id: UUID = UUID()
    let cost: Int
    let quantity: Int
}
