//
//  itemViewModel.swift
//  IOS_FINAL
//
//  Created by lo pui yi on 24/6/2022.
//

import Foundation
import Firebase
import FirebaseFirestore
import SwiftUI

class ItemViewModel: ObservableObject {
    @Published var items: [Item] = []
    private var db = Firestore.firestore()
    
    init() {
        db.collection("ITEMS").whereField("remainingStock", isGreaterThan: 0).addSnapshotListener { querySnapshot, error in
            if error != nil{
                print(error!)
                return
            }
            guard let documents = querySnapshot?.documents else {
                print("No documents")
                return
            }
            
            self.items = documents.map{ queryDocumentSnapshot -> Item in
                let data = queryDocumentSnapshot.data()
  
                let category = data["category"] as? String ?? ""
                let description = data["description"] as? String ?? ""
                let image = data["image"] as? String ?? ""
                let name = data["name"] as? String ?? ""
                let price = data["price"] as? Int ?? 0
                let remainingStock = data["remainingStock"] as? Int ?? 0
                let comments = data["orderItems"] as? [Comment] ?? []
                
                return Item(id: queryDocumentSnapshot.documentID, category: category, comments: comments, description: description, image: image, name: name, price: price, remainingStock: remainingStock)
            }
        }
    }
    
    func getDocumentNameAndImage(itemId: String) -> (String, String) {
        var image = ""
        var name = ""
        for i in items {
            if (i.id == itemId) {
                name = i.name
                image = i.image
                break
            }
        }
        return (name, image)
    }
    
    func findItemByitemId(itemId: String) -> Item {
        var item = Item(id: "", category: "", comments: [], description: "", image: "", name: "", price: 0, remainingStock: 0)
        
        for i in items {
            if (i.id == itemId){
                print("~~~~\(i.name)~~~~")
                print("~~~~\(i.image)~~~~")
            }
        }
        
        db.collection("ITEMS").whereField("uid", isEqualTo:"A80tkdoxWpZNS6FdSW6U").getDocuments { [self] (snap, err) in
            if err != nil {
                print(err!)
                print((err?.localizedDescription)!)
                return
            }
            let firstDoc = snap!.documents.first
            let dataDescription = firstDoc?.data()

            item.id = firstDoc?.documentID
            if let category = dataDescription?["category"] as? String {
                item.category = category
            }

            var item_comments: [Comment] = []
            for c in dataDescription?["comments"] as! [Dictionary<String, AnyObject>] {
                var curr_comment = Comment(date: "", description: "", rate: 0, userName: "")
                curr_comment.id =  c.description.id
                if let date = c["date"] as? String {
                    curr_comment.date = date
                }
                if let description = c["description"] as? String {
                    curr_comment.description = description
                }
                if let rate = c["rate"] as? Int {
                    curr_comment.rate = rate
                }
                if let userName = c["userName"] as? String {
                    curr_comment.userName = userName
                }
                print("commentId-\(c.description.id) : \(String(describing: c["rate"]))")
                item_comments.append(curr_comment)
            }
             
            item.comments = item_comments
            if let description = dataDescription?["description"] as? String {
                item.description = description
            }
            if let image = dataDescription?["image"] as? String {
                item.image = image
            }
            if let name = dataDescription?["name"] as? String {
                item.name = name
            }
            if let price = dataDescription?["price"] as? Int {
                item.price = price
            }
            if let remainingStock = dataDescription?["remainingStock"] as? Int {
                item.remainingStock = remainingStock
            }
        }
        return item
    }
}
