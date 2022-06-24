//
//  Cart_Item.swift
//  IOS_FINAL
//
//  Created by lo pui yi on 24/6/2022.
//

import Foundation
import FirebaseFirestoreSwift

struct Cart_Item: Codable, Identifiable,Equatable {
    @DocumentID var id: String?
    let custID: String
    let itemID: String
    let price:String
    let quantity: Int
}
