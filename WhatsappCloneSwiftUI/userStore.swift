


import SwiftUI
import Firebase
import Combine



class userStore : ObservableObject {
    
    let database = Firestore.firestore()
    
    
    var userArray : [userModel] = []
    
    var objectWillChange = PassthroughSubject<Array<Any>, Never>()
    
    
    init() {
        
        database.collection("Users").addSnapshotListener { (snapshot, error) in
            
            if error != nil {
                
                
                print(error?.localizedDescription ?? "ERROR!")
                
            } else {
                
                
                for document in  snapshot!.documents {
                    
                    
                    if let useruidFromFirebase = document.get("useruidFromFireBase") as? String {
                        
                    
                    if let userName = document.get("username") as? String {
                        
                        let currentindex = self.userArray.last?.id
                        
                        let createUser = userModel(id: (currentindex ?? -1) + 1, name: userName, uidFromFireBase: useruidFromFirebase)
                        
                        self.userArray.append(createUser)
                        
                    }
                    
                }
                
                
            }
            
                self.objectWillChange.send(self.userArray)
                
            
        }
            
    }
        
    
}
    
}

