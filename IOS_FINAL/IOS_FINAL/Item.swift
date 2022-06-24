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
    let category: String
    let comments: [Comment]?
    let description: String
    let image: String
    let name: String
    let price: Int
    let remainingStock: Int
}
