

import Foundation
import SwiftUI
import Firebase
import Combine


class chatStore : ObservableObject{
    
    let db = Firestore.firestore()
    
    
    
    var chatArray : [chatModel] = []
    
    var objectWillChange =  PassthroughSubject<Array<Any>, Never>()
    
    init(){
        
        
        db.collection("Chats").whereField("chatUserFrom", isEqualTo: Auth.auth().currentUser!.uid).addSnapshotListener { (snapshot, error) in
            
            if error != nil {
                
                print(error?.localizedDescription ?? "ERROR!" )
                
            } else {
                 self.chatArray.removeAll(keepingCapacity: false)
                
                
                for document in snapshot!.documents {
                    
                    let chatuidFromFireBase = document.documentID
                    
                    if let chatMessage = document.get("message") as? String {
                        
                        if let messageFrom = document.get("chatUserFrom") as? String {
                            
                            if let messageTo = document.get("chatUserTo") as? String {
                                
                                if let dateString = document.get("date") as? String {
                                    
                                    let dateformatter = DateFormatter()
                                    
                                    dateformatter.dateFormat = "yyyy_MM_dd_hh_mm_ss"
                                    
                                    let dateFromFB = dateformatter.date(from: dateString)
                                    
                                    let currentindex = self.chatArray.last?.id
                                    
                                    let createdChat = chatModel(id: (currentindex ?? -1) + 1, message: chatMessage, uidFromFireBase:chatuidFromFireBase , messageFrom: messageFrom, messageTo: messageTo, messageDate: dateFromFB!, messsageFromMe: true)
                                    
                                    self.chatArray.append(createdChat)
                                    
                                    
                                }
                                
                                
                            }
                            
                            
                        }
                        
                    }
                    
                }
                
                self.db.collection("Chats").whereField("chatUserTo", isEqualTo: Auth.auth().currentUser!.uid).addSnapshotListener { (snapshot, error) in
                    
                    if error != nil {
                        
                      
                        
                    } else {
                       
                        
                        for document in snapshot!.documents {
                            
                            let chatuidFromFireBase = document.documentID
                            
                            if let chatMessage = document.get("message") as? String {
                                
                                if let messageFrom = document.get("chatUserFrom") as? String {
                                    
                                    if let messageTo = document.get("chatUserTo") as? String {
                                        
                                        if let dateString = document.get("date") as? String {
                                            
                                            let dateformatter = DateFormatter()
                                            
                                            dateformatter.dateFormat = "yyyy_MM_dd_hh_mm_ss"
                                            
                                            let dateFromFB = dateformatter.date(from: dateString)
                                            
                                            let currentindex = self.chatArray.last?.id
                                            
                                            let createdChat = chatModel(id: (currentindex ?? -1) + 1, message: chatMessage, uidFromFireBase:chatuidFromFireBase , messageFrom: messageFrom, messageTo: messageTo, messageDate: dateFromFB!, messsageFromMe: true)
                                            
                                            self.chatArray.append(createdChat)
                                            
                                            
                                        }
                                        
                                        
                                    }
                                    
                                    
                                }
                                
                            }
                            
                        }
                        
                        self.chatArray = self.chatArray.sorted(by: {
                            
                            $0.messageDate.compare($1.messageDate) == .orderedDescending
                        })
                        
                        self.objectWillChange.send(self.chatArray)
                        
                    }
                    
                }

                
            }
            
        }
    }
    
}




