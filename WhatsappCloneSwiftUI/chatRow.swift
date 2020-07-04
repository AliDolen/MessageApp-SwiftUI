

import SwiftUI
import Firebase

struct chatRow: View {
    
    var chatMessage : chatModel
    var userToChatFromChatView : userModel
    
    
    
    var body: some View {
        
        Group{
            
            if chatMessage.messageFrom == Auth.auth().currentUser?.uid && chatMessage.messageTo == userToChatFromChatView.uidFromFireBase {
                
                HStack {
                    Text(chatMessage.message)
                   .bold()
                     .foregroundColor(.black)
                      .padding(10)
                    
                    Spacer()
                                                  
                    
                    
                    
                }
               
            } else if chatMessage.messageFrom == userToChatFromChatView.uidFromFireBase && chatMessage.messageTo == Auth.auth().currentUser?.uid {
                
                HStack {
                  
                       
                     Spacer()
                     Text(chatMessage.message)
                     .foregroundColor(.black)
                       .padding(10)
                                  
                     
                                  
                              
                
                }
                
            }
            else {
                
                // no
            }
        
            
        }.frame(width: UIScreen.main.bounds.width * 0.95)
        
        
       
        
    }
}

struct chatRow_Previews: PreviewProvider {
    static var previews: some View {
        chatRow(chatMessage: chatModel(id: 0, message: "hey", uidFromFireBase: "message", messageFrom: "yo", messageTo: "yes", messageDate: Date(), messsageFromMe: true), userToChatFromChatView: userModel(id: 1, name: "hames", uidFromFireBase: "hetfield"))
    }
}
