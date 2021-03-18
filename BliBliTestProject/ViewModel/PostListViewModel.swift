//
//  PostListViewModel.swift
//  Project Bli Bli
//
//  Created by andre basra utama on 10/03/21.
//

import Foundation
import Firebase
import FirebaseFirestore


class PostListViewModel : ObservableObject{
    
    @Published var textForum : String = "";
    
    @Published var posts : [PostItemModel] = [];
    
    @Published var isPostEmpty = false;
    
    @Published var newPost = false;
    var User : UserModel = UserModel.init(username: "", phone: "", gender: "", image: "");
    @Published var updatePost = false;
    
    @Published var idForUpdate : String = "";
    var chatMode : [ChatModel] = []
    @Published var Move = false;
    @Published var PostPending = PostItemModel(id: "", title: "", image: "", time: Date(), user: UserModel(username: "andre", phone: "08121269300", gender: "Male", image: ""), chat: [ChatModel (user: UserModel(username: "andre", phone: "08121269300", gender: "Male", image: ""), message: "donwload hal yang tidak di inginkan", time: Date())]);
    
    
    
    let firestore = Firestore.firestore();
    
    public func Start (){
        
        FetchUser(phone: UserDefaults.standard.string(forKey: "Phone")!) { (UserModel) in
            self.User = UserModel;
        }
        
        
        
    }
    
    
    
    public func getAllPosts (){
        firestore.collection("Post").order(by: FirestorePost.time).addSnapshotListener { (snap, err) in
            guard let docs = snap else {
                self.isPostEmpty = true;
                return
                
            }
            print ()
            print ("ini knp ada isi \(docs.documentChanges.isEmpty)")
            if (docs.documentChanges.isEmpty){
                self.isPostEmpty = true;
                return;
            }
            
            docs.documentChanges.forEach { (doc) in
                
                
                if doc.type == .added{
                    print ("user nya \(doc.document.data()[FirestorePost.user])")
                    let title = doc.document.data()[FirestorePost.title] as! String
                    let time = doc.document.data()[FirestorePost.time] as! Timestamp;
                    let image = doc.document.data()[FirestorePost.image] as! String;
                    let user = doc.document.data()[FirestorePost.user] as! String
                    
                    
                    
                    
                    FetchUser(phone: user) { (User) in
                        
                        self.posts.append(PostItemModel(id: doc.document.documentID, title: title, image: image, time: time.dateValue(), user: User, chat: [ChatModel (user: User, message: "donwload hal yang tidak di inginkan, download juga dengan hal yang benar-benar tidak dinginkan bukan untuksemuanya tapi untuk keseluruhan", time: Date())]))
                    }
                }
                if (doc.type == .removed){
                    let id = doc.document.documentID;
                    
                    self.posts.removeAll { (post) -> Bool in
                        return post.id == id
                    }
                    
                }
                if (doc.type == .modified){
                    let postText = doc.document.data()[FirestorePost.title] as! String;
                    var counter = 0;
                    var idx = -1;
                    
                    for post in self.posts {
                        if (post.id == self.idForUpdate){
                            idx = counter;
                            break;
                        }
                        counter+=1;
                    }
                    
                    if (idx != -1){
                        self.posts[idx].title = doc.document.data()[FirestorePost.title] as! String;
                        self.posts[idx].image = doc.document.data()[FirestorePost.image] as! String;
                    }
                    
                    self.idForUpdate = ""
                }
                
            }
        }
    }
    
    public func delete(id : String){
        firestore.collection("Post").document(id).delete { (err) in
            if (err != nil){
                print (err?.localizedDescription);
            }
        }
    }
    public func edit (id: String){
        idForUpdate = id;
        newPost = true;
        
        
    }
    
}


