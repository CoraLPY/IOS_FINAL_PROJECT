//
//  Cart_Item.swift
//  IOS_FINAL
//
//  Created by lo pui yi on 24/6/2022.
//

import Foundation
import FirebaseFirestoreSwift

struct CartItem: Codable, Identifiable, Equatable {
    @DocumentID var id: String?
    let custID: String
    let itemID: String
    let price: Int
    let quantity: Int
}
