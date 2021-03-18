//
//  DetailViewModel.swift
//  BliBliTestProject
//
//  Created by andre basra utama on 18/03/21.
//

import Foundation
import Firebase


class DetailViewModel : ObservableObject{
    
    var db = Firestore.firestore();
    var userModel = UserModel(username: "", phone: "", gender: "", image: "")
    @Published var Chat : [ChatModel] = []
    @Published var isChatEmpty = false
    @Published var Message  = ""
    func sendMessage(id : String){
        
        var phone = UserDefaults.standard.string(forKey: "Phone")!
        FetchUser(phone: phone) { (User) in
            self.userModel = User
        }
        
        db.collection("Post").document(id)
            .collection("messages").document().setData([
                FirestoreMessage.user : phone,
                FirestoreMessage.message :Message,
                FirestoreMessage.time : Date()
            ]){
                (err) in
                if (err != nil){
                    return
                }
                return
            }
        
    }
    
    func getAllChat (id : String){
        db.collection("Post").document(id).collection("messages").order(by: FirestoreMessage.time).addSnapshotListener { (snap, err) in
            guard let docs = snap else {
                self.isChatEmpty = true;
                return;
            }
            
            print ()
            if (docs.documentChanges.isEmpty){
                self.isChatEmpty = true
                return
            }
            docs.documentChanges.forEach { (doc) in
                if doc.type == .added{
                    let User = doc.document.data()[FirestoreMessage.user] as! String
                    let message = doc.document.data()[FirestoreMessage.message] as! String
                    let time = doc.document.data()[FirestoreMessage.time] as! Timestamp
                    FetchUser(phone: User) { (UserModel) in
                        self.Chat.append(ChatModel (user: UserModel, message: message, time: time.dateValue()
                        ))
                    }
                    
                }
            }
            print (self.Chat)
            
        }
    }
    
    
    
}
