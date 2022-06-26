//
//  RecordItemRow.swift
//  IOS_FINAL
//
//  Created by lo pui yi on 25/6/2022.
//

import SwiftUI

struct RecordItemRow: View {

    var orderitem : OrderItem
    var name,image :String
    var body: some View {
        //
        HStack {
            Image(image)
                .resizable()
                .scaledToFill()
                .frame(width: 80, height: 80)
                .clipped()
          

            VStack(alignment: .leading) {
                Text("\(name)").foregroundColor(Color.ui.OrderBG)
            }
            Spacer()
            VStack(alignment:.trailing){
                Text("Qty:\(orderitem.quantity)").foregroundColor(Color.gray)
                Text("$\(orderitem.cost)").foregroundColor(Color.gray)
                
            }
            
            
            
        }
        .padding(10)
       
    }
}

struct RecordItemRow_Previews: PreviewProvider {
    static var previews: some View {
        RecordItemRow(orderitem: OrderItem(id: "id",itemId:"A80tkdoxWpZNS6FdSW6U", cost: 100, quantity: 20), name: "name", image: "image")
    }
}
