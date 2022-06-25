//
//  itemViewModel.swift
//  IOS_FINAL
//
//  Created by lo pui yi on 24/6/2022.
//

import Foundation
import Firebase
import FirebaseFirestore

class ItemViewModel: ObservableObject {
    @Published var items = [Item]()
    
    private var db = Firestore.firestore()
    
    init() {
        db.collection("ITEMS").getDocuments { [self] (snap, err) in
            if err != nil{
            print(err!)
                print((err?.localizedDescription)!)
                return
            }

            for i in snap!.documents{
                let id = i.documentID
                let category = i.get("category") as! String
                let comments = i.get("comments") as? [Comment] ?? []
                let description = i.get("description") as! String
                let image = i.get("image") as! String
                let name = i.get("name") as! String
                let price = i.get("price") as! Int
                let remainingStock = i.get("remainingStock") as! Int

                self.items.append(Item(id: id, category: category, comments: comments, description: description, image: image, name: name, price: price, remainingStock: remainingStock))
                
//                do {
//                    // add document
//                    try db.collection("ITEMS").addDocument(from: Item(id: id, category: category, comments: comments, description: description, image: image, name: name, price: price, remainingStock: remainingStock))
//                    // edit document
//                    try db.collection("ITEMS").document(id).setData(from: Item(id: id, category: category, comments: comments, description: description, image: image, name: name, price: price, remainingStock: remainingStock))
//                } catch {
//                    print(error)
//                }
            }
        }
    }
}