//
//  OrderItem.swift
//  IOS_FINAL
//
//  Created by Alvin on 2022/6/25.
//

import Foundation
import Firebase
import FirebaseFirestoreSwift

struct OrderItem: Codable, Identifiable, Equatable {
    @DocumentID var id: String?
    var itemId: String
    var cost: Int
    var quantity: Int
}
