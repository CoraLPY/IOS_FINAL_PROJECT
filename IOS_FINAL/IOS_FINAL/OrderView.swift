//
//  OrderView.swift
//  IOS_FINAL
//
//  Created by Alvin on 2022/6/25.
//

import SwiftUI
import FirebaseFirestore
import FirebaseFirestoreSwift

struct OrderView: View {
    @FirestoreQuery(collectionPath: "ORDERS") var orders: [Order]
    
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}

struct OrderView_Previews: PreviewProvider {
    static var previews: some View {
        OrderView()
    }
}
