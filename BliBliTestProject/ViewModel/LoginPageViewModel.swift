//
//  LoginPageViewModel.swift
//  Project Bli Bli
//
//  Created by andre basra utama on 04/03/21.
//

import Foundation
import Firebase
import SDWebImageSwiftUI
import FirebaseFirestore



class LoginPageViewModel : ObservableObject{
    
    @Published var username = "";
    @Published var phone = "";
    @Published var inputVerification = "";
    let db = Firestore.firestore();
    @Published var status = ""
    
    var check =  true;
    
    @Published var show = false;
    
    
    
    public func onTap (){
        let id = "\(Int.random(in: 0...9))\(Int.random(in: 0...9))\(Int.random(in: 0...9))\(Int.random(in: 0...9))"
        
        let image = UIImage(named : "profileTemplate");
        let image_data = image!.jpegData(compressionQuality : 0.5)!;
        
        storeImage(phone : phone, uid : id , imageData: image_data, path: "profile") { (url) in
            do{
                if (self.status == "successfully registered"){
                    
                    try self.db.collection("User").document(self.phone).setData([
                        
                        FirestoreUser.username : self.username,
                        FirestoreUser.phone : self.phone,
                        FirestoreUser.date : Date(),
                        FirestoreUser.gender : "none",
                        FirestoreUser.img : url
                    ]) { err in
                        if let err = err {
                            print("Error writing document: \(err)")
                        } else {
                            print("Document successfully written!")
                        }
                    }
                    
                    
                    
//
//                    try self.db.collection("User").addDocument(data: [
//                        FirestoreUser.id : id,
//                        FirestoreUser.username : self.username,
//                        FirestoreUser.phone : self.phone,
//                        FirestoreUser.date : Date(),
//                        FirestoreUser.gender : "none",
//                        FirestoreUser.img : url
//
//                    ]){
//                        (error) in
//                        if let e = error{
//                            print ( "There was an issue saving data to firestore" )
//                        }
//
//
//                    };
//
//
//
//                    self.status = "user successfully registered"
                    
                }
            }catch let err{
                
            }
            
        }
        
        
    }
    
    
    public func register (){
        
        if (username.isEmpty){
            
            show = true
            status = "username must be filled"
            return;
        }
        if (phone.isEmpty){
            show = true;
            status = "phone must be filled"
            return;
        }else{
            show = true;
            verifyUser()
            
            //            var user : [userModel] = []
            //
            //
            //
            //            db.collection("User").addSnapshotListener { (querySnapshot, error) in
            //                user = [];
            //                if let e = error{
            //                    print ("There was an issue retrieving data from firestore. ");
            //
            //                }else {
            //                    if let snapShotDocuments = querySnapshot?.documents{
            //                        for doc in snapShotDocuments {
            //                            let data = doc.data();
            //                            if (self.username == data[FirestoreUser.username] as? String || self.phone == data[FirestoreUser.phone] as? String){
            //
            //                                print ("username dari yang asli \(self.username)");
            //                                print ("username dari data \(data[FirestoreUser.username])")
            //                                print ("phone dari yang asli \(self.phone)")
            //                                print ("phone dari data \(data[FirestoreUser.phone])")
            //                                self.check = false;
            //                                self.status = "user already registered"
            //                                return;
            //                            }
            //                        }
            //                        do{
            //                            if (self.check == true){
            //                                try self.db.collection("User").addDocument(data: [
            //                                    FirestoreUser.username : self.username,
            //                                    FirestoreUser.phone : self.phone,
            //                                    FirestoreUser.date : Date(),
            //                                    FirestoreUser.gender : "none",
            //                                    FirestoreUser.img : "none"
            //
            //
            //                                ]){
            //                                    (error) in
            //                                    if let e = error{
            //                                        print ( "There was an issue saving data to firestore" )
            //                                    }
            //
            //                                };
            //
            //
            //                                self.status = "user successfully registered"
            //
            //                            }
            //
            //                        }catch let error{
            //
            //                        }
            //
            //
            //
            //                    }
            //                }
            //            }
            
            
            
            
            
            
            
            
            //                db.collection("User").getDocuments { (querySnapshot, error) in
            //                    if let e = error{
            //                        print ("there was an issue retrieving data from firestore" );
            //                    }else{
            //                        if let snapshotDocuments = querySnapshot?.documents{
            //                            for doc in snapshotDocuments{
            //                                let data = doc.data();
            //                                print (self.phone);
            //                                print (data[FirestoreUser.phone]);
            //
            //                                if (self.username == data[FirestoreUser.username] as? String || self.phone == data[FirestoreUser.phone] as? String){
            //                                    self.check = false;
            //                                    print (self.check)
            //                                    return;
            //                                }
            //                            }
            //                        }
            //
            //                    }
            //                }
            
            //
            //            if (self.verifyUser() == false){
            //                self.status = "user already registered";
            //            }else{
            //
            //
            //                try self.db.collection("User").addDocument(data: [
            //                    FirestoreUser.username : self.username,
            //                    FirestoreUser.phone : self.phone,
            //                    FirestoreUser.date : Date(),
            //                    FirestoreUser.gender : "none",
            //                    FirestoreUser.img : "none"
            //
            //
            //                ]){
            //                    (error) in
            //                    if let e = error{
            //                        print ( "There was an issue saving data to firestore" )
            //                    }
            //
            //                };
            //
            //
            //                self.status = "user successfully registered"
            //            }
            //
            //
            ////                status = "user successfully registered"
            //
            //            return;
        }
        
    }
    
    
    public func verifyUser () -> Bool
    {
        
        var user : [UserModel] = []
        
        db.collection("User").addSnapshotListener { (querySnapshot, error) in
            user = [];
            if let e = error{
                print ("There was an issue retrieving data from firestore. ");
                
            }else {
                if let snapShotDocuments = querySnapshot?.documents{
                    print ("masuk sini dulu 1")
                    if (snapShotDocuments == []){
                        self.status = "successfully registered"
                    }else{
                        for doc in snapShotDocuments {
                            print ("masuk sini dulu")
                            let data = doc.data();
                            if (self.username == data[FirestoreUser.username] as? String || self.phone == data[FirestoreUser.phone] as? String){
                                
                                print ("username dari yang asli \(self.username)");
                                print ("username dari data \(data[FirestoreUser.username])")
                                print ("phone dari yang asli \(self.phone)")
                                print ("phone dari data \(data[FirestoreUser.phone])")
                                DispatchQueue.main.async {
                                    self.check = false;
                                    self.status = "user already registered"
                                }
                                break;
                            }
                            self.status = "successfully registered"
                        }
                    }
                    
                    
                }
            }
        }
        
        print ("check sebelym returm \(self.check)")
        return check;
        
        
        
        
        
        
        
        
        
        
        //        db.collection("cities").document("SF")
        //            .addSnapshotListener { documentSnapshot, error in
        //              guard let document = documentSnapshot else {
        //                print("Error fetching document: \(error!)")
        //                return
        //              }
        //              guard let data = document.data() else {
        //                print("Document data was empty.")
        //                return
        //              }
        //              print("Current data: \(data)")
        //            }
        
        //
        //        db.collection("User").getDocuments { (querySnapshot, error) in
        //            if let e = error{
        //                print ("there was an issue retrieving data from firestore" );
        //            }else{
        //                if let snapshotDocuments = querySnapshot?.documents{
        //                    for doc in snapshotDocuments{
        //                        let data = doc.data();
        //                        print (self.phone);
        //                        print (data[FirestoreUser.phone]);
        //
        //                        if (self.username == data[FirestoreUser.username] as? String || self.phone == data[FirestoreUser.phone] as? String){
        //                            self.check = false;
        //                            print (self.check)
        //                            return;
        //                        }
        ////
        //
        //
        //                    }
        //                    do{
        //                        if (self.verifyUser() == false){
        //                            self.status = "user already registered";
        //                        }else{
        //
        //
        //                            try self.db.collection("User").addDocument(data: [
        //                                FirestoreUser.username : self.username,
        //                                FirestoreUser.phone : self.phone,
        //                                FirestoreUser.date : Date(),
        //                                FirestoreUser.gender : "none",
        //                                FirestoreUser.img : "none"
        //
        //
        //                            ]){
        //                                (error) in
        //                                if let e = error{
        //                                    print ( "There was an issue saving data to firestore" )
        //                                }
        //
        //                            };
        //
        //
        //                            self.status = "user successfully registered"
        //                        }
        //                    }catch let error{
        //
        //                    }
        //
        //
        //
        //                }
        //
        //            }
        //        }
        
    }
    
    
    
    
    
    
    
    
    
    public func testUser (){
//        UserDefaults.standard.setValue(nil, forKey: "Phone");
//        do{
//            try Auth.auth().signOut();}
//            catch let error{
//
//            }
//        print (Auth.auth().currentUser?.phoneNumber);

        
//        db.collection("Post").delete() { err in
//            if let err = err {
//                print("Error removing document: \(err)")
//            } else {
//                print("Document successfully removed!")
//            }
//        }
        
    }
}
