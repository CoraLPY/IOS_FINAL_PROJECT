//
//  ProductBoxView.swift
//  IOS_FINAL
//
//  Created by Alvin on 2022/6/23.
//

import SwiftUI

struct ProductBoxView: View {
    let item: Item
    
    var body: some View {
        VStack(alignment: .leading) {
            Image(item.image)
                .resizable()
                .scaledToFit()
                .frame(width: 150, height: 150)
            
            Text(item.name)
                .lineLimit(2)
            
            Text("Price:$ \(item.price)")
            
            Text("Qty: \(item.remainingStock)")
        }
        .padding(20)
        //.border(Color.black)
        .background()
        .cornerRadius(8)
        .shadow(radius: 10)
    }
}

struct ProductBoxView_Previews: PreviewProvider {
    static var previews: some View {
        HStack {
            ProductBoxView(item: Item(category: "NOTES", comments: [], description: "Prof sticky notes", image: "notes1", name: "Yellow Sticky notes", price: 10, remainingStock: 30))
        }
    }
}
