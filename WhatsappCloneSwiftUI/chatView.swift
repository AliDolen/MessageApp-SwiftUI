

import SwiftUI
import Firebase

struct chatView: View {
    
    var usertoChat : userModel
    
    var database = Firestore.firestore()
    
    @State var messagetoSend = ""
    
    @ObservedObject var chatstore = chatStore()
    
    var body: some View {
        
        VStack {
            
            ScrollView{
                
                ForEach(chatstore.chatArray) { chats in
                    
                     chatRow(chatMessage: chats, userToChatFromChatView: self.usertoChat)
                  
                }
                
            }
            
           
            
            HStack {
                
                TextField("message Here", text: $messagetoSend)
                    .frame(minHeight: 30)
                    .padding()
                Button(action: sendMessageToFireBase) {
                            
                   Text("Send")
                    
                    }.frame(minHeight: 50).padding()
                   
                
            }
            
        }
    }
    
    func sendMessageToFireBase() {
        
        var ref : DocumentReference?
        
        
        let myChatDic : [String : Any] = ["chatUserFrom" : Auth.auth().currentUser?.uid,"chatUserTo" : usertoChat.uidFromFireBase ,"date" : generateDate(),"message" : self.messagetoSend]
        
        
        ref = database.collection("Chats").addDocument(data: myChatDic, completion: { (error) in
            if error != nil {
                
                print(error?.localizedDescription ?? "ERROR!")
                
            } else {
                
                self.messagetoSend = ""
                
            }
        })
        
        
    }
    func generateDate () -> String {
        
        let formatter = DateFormatter()
        
        formatter.dateFormat = "yyyy_MM_dd_hh_mm_ss"
        
        return (formatter.string(from: Date()) as NSString) as String
        
        
        
    }
    
}

struct chatView_Previews: PreviewProvider {
    static var previews: some View {
        chatView(usertoChat: userModel(id: 0, name: "james", uidFromFireBase: "123456"))
    }
}
