//
//  LikedPeople.swift
//  Flick
//
//  Created by Gruber, John David on 12/13/20.
//

import SwiftUI
import Firebase

struct LikedPeople: View {
    
    @ObservedObject var datas = observer1()
    var body: some View {
        
        
        
        VStack{
            if datas.data.isEmpty{
                Text("No liked Films")
            }else {
                List(datas.data){ i in
                    //cards(title: i.title, image: i.image)
                }
            }
            
    
        }
    }
}

struct cards : View {
    var title = ""
    var image = ""
    var flick: Film
    var body : some View{
        
        HStack {
            Image(flick.image)
                .resizable()
                .frame(width: 65, height: 65)
                .clipShape(Circle())
            
            Text(flick.title.uppercased())
                .fontWeight(.heavy)
        }
    }
}

class observer1 : ObservableObject{
    
    @Published var data = [userData]()
    
    init() {
        let db = Firestore.firestore()
        db.collection("liked").getDocuments { (snap, err) in
            if err != nil{
                
                print((err?.localizedDescription)!)
                return
            }
            
            for i in snap!.documents{
                let name = i.get("name") as! String
                let image = i.get("image") as! String
                
                self.data.append(userData(name: name, image: image, id: UUID().uuidString))
            }
        }
    }
}

struct LikedPeople_Previews: PreviewProvider {
    static var previews: some View {
        LikedPeople()
    }
}
