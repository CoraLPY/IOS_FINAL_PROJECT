//
//  RecordItemRow.swift
//  IOS_FINAL
//
//  Created by lo pui yi on 25/6/2022.
//

import SwiftUI

struct RecordItemRow: View {

    var orderitem : OrderItem
    var item: Item
    var body: some View {
        //
        HStack {
            Image(item.image)
                .resizable()
                .scaledToFill()
                .frame(width: 80, height: 80)
                .clipped()
            
            VStack(alignment: .leading) {
                
                Text("\(item.name)")
                Text("\(orderitem.quantity)")
                Text("\(orderitem.cost)")
            }
            Spacer()
            
        }
       
    }
}

struct RecordItemRow_Previews: PreviewProvider {
    static var previews: some View {
        RecordItemRow(orderitem: OrderItem(id: "id",itemId:"A80tkdoxWpZNS6FdSW6U", cost: 100, quantity: 20),item:Item(id: "", category: "", comments: [], description: "", image: "", name: "", price: 0, remainingStock: 0))
    }
}
