//
//  Comment.swift
//  IOS_FINAL
//
//  Created by lo pui yi on 24/6/2022.
//

import Foundation
import FirebaseFirestoreSwift

struct  Comment: Codable, Identifiable, Equatable {
    var id: UUID = UUID()
    let date: String
    let description: String
    let rate: Int
    let userName: String
}

<<<<<<< HEAD


=======
>>>>>>> 2a8ac255eddd35ab4080b46da7b3e35d46bd4d10
/*
extension Comment {
    static let demoComment=Comment(date: "2022-5-22", description: "Good", rate: "5", userName: "Mary")
}
*/
