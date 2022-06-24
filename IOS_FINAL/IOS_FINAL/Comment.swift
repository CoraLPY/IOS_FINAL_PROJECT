//
//  Comment.swift
//  IOS_FINAL
//
//  Created by lo pui yi on 24/6/2022.
//

import Foundation
import FirebaseFirestoreSwift

struct  Comment: Codable, Identifiable,Equatable {
    @DocumentID var id: String?
    let date: String
    let description: String
    let rate: String
    let userName:String
    
}

