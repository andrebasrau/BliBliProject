//
//  NewPostViewModel.swift
//  Project Bli Bli
//
//  Created by andre basra utama on 11/03/21.
//

import Foundation
import Firebase
import FirebaseFirestore

class NewPostViewModel : ObservableObject{
    
    
    @Published var postText = "";
    @Published var pickImage = false;
    @Published var img = Data (count : 0);
    var firestore = Firestore.firestore();
    var id = "";
    
    @Published var posting = false
    
    func Post (idForUpdate : String){
        posting = true;
        
        id = "\(Int.random(in: 0...9))\(Int.random(in: 0...9))\(Int.random(in: 0...9))\(Int.random(in: 0...9))\(Int.random(in: 0...9))\(Int.random(in: 0...9))"
        
        if (img.count == 0){
            if (idForUpdate != ""){
                firestore.collection("Post").document(idForUpdate).updateData([
                    FirestorePost.title : postText,
                    
                    
                    
                ]) { (err) in
                    if (err != nil){
                        return;
                    }
                }
                return;
            }
            firestore.collection("Post").document().setData([
                FirestorePost.title : self.postText,
                FirestorePost.image : "",
                FirestorePost.user : UserDefaults.standard.string(forKey: "Phone")!,
                FirestorePost.time : Date(),
                
                ]) {
                (err) in
                if err != nil{
                    self.posting = false;
                    return;
                }
                self.posting = false;
                return;
            }
        }else{
            let id = "\(Int.random(in: 0...9))\(Int.random(in: 0...9))\(Int.random(in: 0...9))\(Int.random(in: 0...9))"
            let phone = UserDefaults.standard.string(forKey: "Phone")!;
            storeImage(phone : phone , uid : id , imageData: img, path: "post_img") { (url) in
                if (idForUpdate != ""){
                    self.firestore.collection("Post").document(idForUpdate).updateData([
                    
                        FirestorePost.title : self.postText,
                        FirestorePost.image : url
                    
                    ]) { (err) in
                        
                    }
                    
                    
                    return;
                }
                self.firestore.collection("Post").document().setData([
                    
                    FirestorePost.id : id,
                    FirestorePost.title : self.postText,
                    FirestorePost.image : url,
                    FirestorePost.user : UserDefaults.standard.string(forKey: "Phone")!,
                    FirestorePost.time : Date()
                
                ]) {
                    (err) in
                    if err != nil{
                        self.posting = false;
                        return;
                    }
                    self.posting = false;
                    return;
                }
            }
        }
        
       
        
        
        
        
        
        
    }
}
