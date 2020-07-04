
import SwiftUI
import Firebase


struct AuthView: View {
    
    var database = Firestore.firestore()
    
    @ObservedObject var userstore = userStore()
    
    
    @State var showAuthView = true
    
    @State var useremail = ""
    @State var username = ""
    @State var password = ""
        
        
    
    var body: some View {
        
        NavigationView{
            
            if showAuthView == true {
                
                
      
        List{
            Text("Whatsapp")
                .font(.largeTitle)
            .bold()
            
            
            Section {
                
                VStack(alignment: .leading){
                    
                    sectionSubtitle(subtitle: "User E-mail")
                    
                    TextField("Useremail:", text:$useremail)
                    
                    
                }
                    
                
                
            }
            Section {
                           
                           VStack(alignment: .leading){
                               
                               sectionSubtitle(subtitle: "UserName")
                               
                               TextField("Username:", text:$username)
                               
                               
                           }
                           
                           
                           
                       }
            Section {
                           
                           VStack(alignment: .leading){
                               
                               sectionSubtitle(subtitle: "Password")
                               
                               TextField("Password:", text:$password)
                               
                               
                           }
                           
                           
                           
                       }
            
            Section {
                
                
                Button(action: {
                    
                    Auth.auth().signIn(withEmail: self.useremail, password: self.password) { (result, error) in
                        if error != nil {
                            
                            print(error?.localizedDescription ?? "ERROR!")
                            
                        } else {
                            
                            
                            self.showAuthView = false
                            
                        }
                    }
                    
                    
                }) {
                    HStack{
                    Spacer()
                    Text("Sign in")
                    Spacer()
                            
                    
                }
                }
                
                
            }
            Section {
                         
                         
                         Button(action: {
                             
                            let user = Auth.auth()
                            
                            user.createUser(withEmail: self.useremail, password: self.password) { (result, error) in
                                if error != nil {
                                    
                                    print(error?.localizedDescription)
                                    
                                    
                                } else {
                                    
                                
                                    var ref : DocumentReference? = nil
                                    
                                                                        
                                    let myUserDic : [String : Any] = ["username" : self.username , "email" : self.useremail, "useruidFromFireBase" : result?.user.uid]
                                    
                                    
                                    ref = self.database.collection("Users").addDocument(data: myUserDic, completion: { (error) in
                                        
                                        if error != nil {
                                            
                                            print(error?.localizedDescription ?? "ERROR!" )
                                            
                                                
                                            }
                                    
                                    })
                                    self.showAuthView = false
                                }
                                
                            }
                            
                         }) {
                             HStack{
                             Spacer()
                             Text("Sign up")
                             Spacer()
                                     
                             
                         }
                         }
                         
                         
                     }
            
            
        }
        
        
            } else {
                NavigationView{
                
                    List(userstore.userArray) { user in
                        NavigationLink(destination: chatView(usertoChat: user)) {
                            
                            Text(user.name)
                                                  
                            
                        }
                      
                        
                        }
                        
                        
                }.navigationBarTitle("Chat With Users")
                    .navigationBarItems(leading: Button(action: {
                        // logout firebase
                        do {
                            
                            
                           try Auth.auth().signOut()
                            
                            
                        } catch {
                        
                        
                        
                        }
                        self.showAuthView = true
                        
                    }, label: {
                        Text("LogOut")
                        
                    }))
                
                
                }
            }
}
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        Group{
        AuthView(showAuthView:false)
        AuthView(showAuthView:true)
    }
    }}

struct sectionSubtitle : View {
    
    var subtitle : String
        
    var body: some View {
        
        
        Text(subtitle)
            .font(.subheadline)
            .foregroundColor(.blue)
        .bold()
        
        
        
    }
    
    
    
}
