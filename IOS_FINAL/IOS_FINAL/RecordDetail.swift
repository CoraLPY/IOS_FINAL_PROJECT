//
//  RecordDetail.swift
//  IOS_FINAL
//
//  Created by lo pui yi on 25/6/2022.
//

import SwiftUI

struct RecordDetail: View {
   var record: Order
    @ObservedObject var  itemModel = ItemViewModel()
    @ObservedObject var  orderModel = OrderViewModel()
    @State  var isProgess = false
    @State private var showAlert = false
    
    
    
   
    
    var body: some View {
        ScrollView{
            VStack(alignment:.center,spacing: 10){
                Group {
                    HStack{
                        Text("Date:")
                             Spacer()
                        Text("\(record.date)")
                    }.padding(10)
                    
                    HStack{
                        Text("Shipping Address:")
                             Spacer()
                        Text("\(record.address)")
                    }.padding(10)
                    
                    HStack{
                        Text("paymentMethod:")
                             Spacer()
                        Text("\(record.paymentMethod)")
                    }.padding(10)
                    
                    HStack{
                        Text("pickupMethod: ")
                             Spacer()
                        Text("\(record.pickupMethod)")
                    }.padding(10)
            
                
                Divider()
              
                Text("Order Items:")
                    .bold()
                }
                Divider()
                
                //show order items
                ForEach(record.orderItems ?? []){ orderItem in
                    let result = itemModel.getDocumentNameAndImage(itemId: orderItem.itemId)
                    
                    RecordItemRow(orderitem: orderItem, name: result.0, image: result.1)
                    Divider()
                       
                    }
                
               
                HStack{
                    Text("Total Cost:")
                         Spacer()
                    Text("$ \(record.cost)")
                }.padding(10)
                HStack{
                    Text("Status:")
                         Spacer()
                    Text("\(record.status)")
                }.padding(10)
                
                   
                
                if(isProgess){
                    Button(action: {
                        showAlert = true
                    }, label: {
                        Text("Cancel")
                            .fontWeight(.bold)
                            .font(.system(size: 15))
                            .padding()
                            .background(Color.red)
                            .cornerRadius(40)
                            .foregroundColor(.white)
                            .padding(10)
                            .overlay(
                                RoundedRectangle(cornerRadius: 40)
                                    .stroke(Color.red, lineWidth: 5)
                            )
                    }
                    ) .padding(30)
                    
                        .alert("Warning", isPresented: $showAlert, actions: {
                           Button("OK") {
                               var modifyOrder = record
                               modifyOrder.status = "cancel"
                               orderModel.modifyOrder(order: modifyOrder)
                           }
                           Button("Cancel", role: .cancel) {
                           }
                           
                        }, message: {
                            Text("Do you want to delete the order?")
                        })

            }
        }.navigationTitle("Order Details")
            .onAppear(){
                isProgess = record.status == "progress" ? true : false
                
            }
    }
    

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
