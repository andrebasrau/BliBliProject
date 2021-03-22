//
//  ProfileViewModel.swift
//  BliBliTestProject
//
//  Created by andre basra utama on 15/03/21.
//

import Foundation
import Firebase


public class ProfileViewModel : ObservableObject {
    
    @Published var UserProfile : UserModel = UserModel.init(username: "", phone: "", gender: "", image: "");
    
    @Published var sendToSetting = false;
    
    init() {
        sendToSetting = false;
    }
    
    public func getUser (){
        sendToSetting = false;
        let phone = UserDefaults.standard.string(forKey: "Phone")!
        
        FetchUser(phone: phone) { (User) in
            self.UserProfile = User;
            
        }
        print ("gendernya jangan aneh2 \(UserProfile.gender)")
        print ("sendtoSetting \(sendToSetting)")
//        if (UserProfile.gender == ""){
//            sendToSetting = true;
//        }
        
    }
    
    
    public func signOut(){
        
        do{
            UserDefaults.standard.setValue(nil, forKey: "Phone");
            try Auth.auth().signOut();
        }catch {
            
        }
        

    }
    
    
    
    
    
    
    
    
}
