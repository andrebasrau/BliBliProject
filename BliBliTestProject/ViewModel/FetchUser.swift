//
//  FetchUser.swift
//  Project Bli Bli
//
//  Created by andre basra utama on 10/03/21.
//

import Foundation
import Firebase
import FirebaseFirestore
let firestore = Firestore.firestore();

func FetchUser (phone : String, completion: @escaping (UserModel) -> ()){
    firestore.collection("User").document(phone).getDocument{
        (doc, err) in
        
        print (UserDefaults.standard.string(forKey: "Phone")!)
        
        
        
        guard let user = doc else {return}
        print ("jangan aneh-aneh \(user.data()?[FirestoreUser.username])")
        print ("download \(user.data())");
        let username = user.data()?[FirestoreUser.username] as! String;
        let image = user.data()?[FirestoreUser.img] as! String;
        let phone = user.data()?[FirestoreUser.phone] as! String;
        let gender = user.data()?[FirestoreUser.gender] as! String
        
        
        DispatchQueue.main.async {
            completion(UserModel(username: username, phone: phone, gender: gender, image: image))
        }
        
        
    }
    
    
}
