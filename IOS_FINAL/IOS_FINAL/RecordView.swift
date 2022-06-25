//
//  RecordView.swift
//  IOS_FINAL
//
//  Created by lo pui yi on 25/6/2022.
//

import SwiftUI

struct RecordView: View {
    let status = ["progress", "complete", "cancel"]
    @State private var selectedStatus = "progress"
    @ObservedObject var orderViewModel = OrderViewModel()
    
    
    var body: some View {
      
        NavigationView{
            ScrollView{
                VStack{
                    //status picker
                    Picker(selection: $selectedStatus) {
                        ForEach(status) { s in
                            Text(s)
                        }
                    } label: {
                        Text("select status")
                    }
                    .pickerStyle(.segmented)
             
                    //show order
                    ForEach(orderViewModel.orders.filter{$0.status.localizedStandardContains(self.selectedStatus)}){ order in
                            NavigationLink {
                                
                                RecordDetail(record: order)
                                
                                
                            } label: {
                               //let _ = print(order.orderItems!.count)
                                RecordRow(order: order)
                                
                            }
                           
                        }

                }
            }
        }
}
}

struct RecordView_Previews: PreviewProvider {
    static var previews: some View {
        RecordView()
    }
}
