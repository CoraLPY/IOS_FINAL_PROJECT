//
//  Item.swift
//  IOS_FINAL
//
//  Created by lo pui yi on 24/6/2022.
//

import Firebase
import FirebaseFirestoreSwift

struct Item: Codable, Identifiable, Equatable {
    @DocumentID var id: String?
    var category: String
    var comments: [Comment]?
    var description: String
    var image: String
    var name: String
    var price: Int
    var remainingStock: Int
}
