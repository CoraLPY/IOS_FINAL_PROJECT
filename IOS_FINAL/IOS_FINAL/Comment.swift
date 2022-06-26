//
//  Comment.swift
//  IOS_FINAL
//
//  Created by lo pui yi on 24/6/2022.
//

import Foundation
import FirebaseFirestoreSwift

struct Comment: Codable, Identifiable, Equatable {
    @DocumentID var id: String?
    var date: String
    var description: String
    var rate: Int
    var userName: String
}

/*
extension Comment {
    static let demoComment=Comment(date: "2022-5-22", description: "Good", rate: "5", userName: "Mary")
}
*/
