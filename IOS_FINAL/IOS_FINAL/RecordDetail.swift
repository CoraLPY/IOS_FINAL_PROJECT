//
//  RecordDetail.swift
//  IOS_FINAL
//
//  Created by lo pui yi on 25/6/2022.
//

import SwiftUI

struct RecordDetail: View {
   let record: Order
    @ObservedObject var  itemModel = ItemViewModel()
    
    var body: some View {
        ScrollView{
            VStack(alignment:.leading){
                Text("Date: \(record.date)")
                Text("Shipping Address: \(record.address)")
                Text("paymentMethod: \(record.paymentMethod)")
                Text("pickupMethod: \(record.pickupMethod)")
                
              
                Text("Order Items:")
                    .bold()
                //show order items
                
                ForEach(record.orderItems ?? []){ orderItem in
                    //let i = itemModel.findItemByitemId(itemId: orderItem.itemId)
                    let i = itemModel.getDocument(itemId: orderItem.itemId)
                    //let _ = print("~~~~\(i.id)")
                    RecordItemRow(orderitem: orderItem,item: i)
                       
                    }
                
                Text("Total Cost:$ \(record.cost)")

                Text("Status: \(record.status)")
                
                
            }
        }.navigationTitle("Record Detail")
    }
}

struct RecordDetail_Previews: PreviewProvider {
    static var previews: some View {
        RecordDetail(record: Order(address: "No. 219-1, Sec. 3, Zhongxiao E. Rd., Da’an Dist., Taipei City 106082, Taiwan (R.O.C.)", cost: 100, custId: "FWywzWzgx6VbwK9rh1IV7zgLhy13", date: "2021-01-05", orderItems:  [
            OrderItem(itemId:"A80tkdoxWpZNS6FdSW6U",cost: 10, quantity: 2),
            OrderItem(itemId:"A80tkdoxWpZNS6FdSW6U", cost: 10, quantity: 1)
         ], paymentMethod: "VISA", pickupMethod: "shipping", status: "progress"))
    }
}
