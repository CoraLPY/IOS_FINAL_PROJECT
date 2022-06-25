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
                        Text("select Category")
                    }
                    .pickerStyle(.segmented)
             
                    //show order
              
                        ForEach(orderViewModel.orders){ order in
                            OrderBoxView(order: order)
                        }
                    
             
                    
                }
            }
        }
       
    }
}

struct OrderView_Previews: PreviewProvider {
    static var previews: some View {
        OrderView()
    }
}
