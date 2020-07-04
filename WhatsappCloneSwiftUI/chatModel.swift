

import Foundation
import SwiftUI


struct chatModel : Identifiable {
    
    var id : Int
    var message : String
    var uidFromFireBase : String
    var messageFrom : String
    var messageTo : String
    var messageDate : Date
    
    var messsageFromMe : Bool
    
    
    
    
}
