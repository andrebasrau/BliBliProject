//
//  SettingViewModel.swift
//  BliBliTestProject
//
//  Created by andre basra utama on 15/03/21.
//

import Foundation
import Firebase
import SDWebImage

public class SettingViewModel : ObservableObject{
    
    @Published var Username = "";
    @Published var gender = ""
    
    @Published var img = Data(count: 0);
    @Published var date = Date();
    @Published var picker = false;
    @Published var UserProfile : UserModel = UserModel.init(username: "", phone: "", gender: "", image: "");
    @Published var index = 0;
    var db = Firestore.firestore();
    
    func getUser (){
        var phone = UserDefaults.standard.string(forKey: "Phone")!
        FetchUser(phone: phone) { (UserModel) in
            self.UserProfile = UserModel;
        }
        Username = UserProfile.username;
        
        
    }
    func updateProfile (){
        let id = "\(Int.random(in: 0...9))\(Int.random(in: 0...9))\(Int.random(in: 0...9))\(Int.random(in: 0...9))"
        var phone = UserDefaults.standard.string(forKey: "Phone")!
        storeImage(phone : phone, uid: id, imageData: img, path: "profile") { (url) in
            self.db.collection("User").document(phone).updateData([
                FirestoreUser.img : url
            ])
            self.UserProfile.image = url
            
        }
        
        
        
    }
    
    func save (){
        if (Username == ""){
            Username = UserProfile.username;
        }
        
        var phone = UserDefaults.standard.string(forKey: "Phone")!;
        
        if (index == 0){
            gender = "Male"
        }else {
            gender = "Female"
        }
        
        db.collection("User").document(phone).updateData([
            FirestoreUser.username : Username,
            FirestoreUser.date : date,
            FirestoreUser.gender : gender
        
        ])
        
        
        
        
    }
    
}
