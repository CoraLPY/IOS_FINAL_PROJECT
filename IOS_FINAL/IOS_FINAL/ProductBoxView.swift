//
//  ProductBoxView.swift
//  IOS_FINAL
//
//  Created by Alvin on 2022/6/23.
//

import SwiftUI

struct ProductBoxView: View {
    let imageName: String
    let itemName: String
    let price: Int
    let qty: Int
    
    var body: some View {
        VStack(alignment: .leading) {
            Image(imageName)
                .resizable()
                .scaledToFit()
                .frame(width: 150, height: 150)
            
            Text(itemName)
            
            Text("Price: \(price)")
            
            Text("Qty: \(qty)")
        }
        .padding()
        .border(Color.black)
    }
}

struct ProductBoxView_Previews: PreviewProvider {
    static var previews: some View {
        ProductBoxView(imageName: "notes1", itemName: "Notes 1", price: 10, qty: 1)
    }
}
