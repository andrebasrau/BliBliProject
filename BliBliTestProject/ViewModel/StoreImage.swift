//
//  StoreImage.swift
//  BliBliTestProject
//
//  Created by andre basra utama on 14/03/21.
//

import Foundation
import FirebaseFirestore
import Firebase


func storeImage (phone : String, uid : String, imageData : Data, path : String , completion : @escaping (String) -> ()){
    
    
    let storage = Storage.storage().reference()
    
    
    storage.child(path).child(phone).putData(imageData, metadata: nil) {
        (_, err) in
        if err != nil {
            completion ("");
            return;
        }
        storage.child(path).child(phone).downloadURL { (url, error) in
            if err != nil {
                completion ("")
                return;
            }
            completion ("\(url!)");
        }
    }
}
