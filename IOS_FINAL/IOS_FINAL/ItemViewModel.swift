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
   // @Published var items = [Item]()
    @Published var items :[Item] = []
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
        
        
       /* db.collection("ITEMS").getDocuments { [self] (snap, err) in
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

                self.items.append(Item(id: id, category: category, comments: comments, description: description, image: image, name: name, price: price, remainingStock: remainingStock))*/
                
//                do {
//                    // add document
//                    try db.collection("ITEMS").addDocument(from: Item(id: id, category: category, comments: comments, description: description, image: image, name: name, price: price, remainingStock: remainingStock))
//                    // edit document
//                    try db.collection("ITEMS").document(id).setData(from: Item(id: id, category: category, comments: comments, description: description, image: image, name: name, price: price, remainingStock: remainingStock))
//                } catch {
//                    print(error)
//                }
            
    }
       /* func findItem(itemId:String)  {
            db.collection("ITEMS").getDocuments { [self] (snap, err) in
                 if err != nil{
                 print(err!)
                     print((err?.localizedDescription)!)
                     return
                 }

                    let i = snap!.documents[0]
                     let id = i.documentID
                     let category = i.get("category") as! String
                     let comments = i.get("comments") as? [Comment] ?? []
                     let description = i.get("description") as! String
                     let image = i.get("image") as! String
                     let name = i.get("name") as! String
                     let price = i.get("price") as! Int
                     let remainingStock = i.get("remainingStock") as! Int
        
                self.orderItem = Item(id: id, category: category, comments: comments, description: description, image: image, name: name, price: price, remainingStock: remainingStock)
        
            }
        }*/
    
     func getDocument(itemId: String) -> Item {
         var item  =  Item(id: "", category: "", comments: [], description: "", image: "", name: "", price: 0, remainingStock: 0)
           let docRef = Firestore.firestore()
               .collection("ITEMS")
               .document("\(itemId)")

           // Get data
           docRef.getDocument { (document, error) in
               guard let document = document, document.exists else {
                   print("Document does not exist")
                   return
               }
               let dataDescription = document.data()
               
               if let category = dataDescription?["category"] as? String {
                   item.category = category
               }
               if let comments = dataDescription?["comments"] as? [Comment] {
                   item.comments = comments
               }
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
               print("\(dataDescription?["remainingStock"]), \(dataDescription?["name"])")
           }
         
         return item
       }
    
    func findItemByitemId(itemId: String) -> Item {
        var item  =  Item(id: "", category: "", comments: [], description: "", image: "", name: "", price: 0, remainingStock: 0)
        

        
        db.collection("ITEMS").whereField("uid", isEqualTo:"A80tkdoxWpZNS6FdSW6U").getDocuments { [self] (snap, err) in
             if err != nil{
             print(err!)
                 print((err?.localizedDescription)!)
                 return
             } else {
                 
                let i = snap!.documents.first
                 let dataDescription = i?.data()
                 
                 item.id = i?.documentID
                 //print(dataDescription)
                 if let category = dataDescription?["category"] as? String {
                     item.category = category
                 }
                 if let comments = dataDescription?["comments"] as? [Comment] {
                     item.comments = comments
                 }
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
                 
                 
                    //item.category = i.get("category") as! String
            //item.comments = dataDescription?["comments"] as? [Comment] ?? []
            //item.description = i.get("description") as? String ?? ""
            //item.image = i.get("image") as! String
            //item.name = i.get("name") as! String
            //item.price = i.get("price") as! Int
            //item.remainingStock = i.get("remainingStock") as! Int
            //print("id:\( item.id), name:\(item.name)")
        }
        }
            return item
  
    
}

}
