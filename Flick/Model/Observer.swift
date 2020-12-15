//
//  Observer.swift
//  Flick
//
//  Created by Gruber, John David on 12/13/20.
//

import SwiftUI
import Firebase


class observer : ObservableObject {
    @Published var users = [Film]()
    @Published var last = -1
    
    init() {
        let db = Firestore.firestore()
        
        db.collection("users").getDocuments { (snap, err) in
            if err != nil {
                print((err?.localizedDescription)!)
                return
            }
            
//            for i in snap!.documents{
//                let title = i.get("title") as! String
//                let genre = i.get("genre") as! String
//                let image = i.get("image") as! String
//                //let id = i.documentID
//                //let status = i.get("status") as! String
//
//
//                //if status == ""{
//                //    self.users.append(Film(title: title, genre: genre, image: image,  swipe: 0, id: id))
//                //}
//            }
            
        }
    }
    
    //func update(id : datatype,value : CGFloat,degree : Double){
        
   // }
}
