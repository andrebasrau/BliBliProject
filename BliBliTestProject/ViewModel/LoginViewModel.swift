//
//  LoginViewModel.swift
//  Project Bli Bli
//
//  Created by andre basra utama on 04/03/21.
//

import Foundation
import Firebase
import FirebaseFirestore

class loginViewModel : ObservableObject{
    
    
    @Published var phone = "";
    @Published var show = false;
    @Published var OTP = "";
    
    @Published var show2 = false;
    
    @Published var check = false;
    @Published var status = ""
    @Published var sendToOtherScene = false;
    @Published var idDocument = "";
    
    
    var verifyId : String?;
    var db = Firestore.firestore();
    
    
    public func AutoLogin (){
//        UserDefaults.standard.setValue(nil, forKey: "Phone")
        
        if (UserDefaults.standard.string(forKey: "Phone") != nil){
            sendToOtherScene = true;
        }
        
        
    }
    
    public func verifyUser(){
        
        check = false;
        show = false;
        show2 = false;
        db.collection("User").addSnapshotListener { (querySnapshot, error) in
            if let e = error{
                print (e.localizedDescription);
            }else{
                print ("lewat verify dulu tidak")
                if let snapShotDocument = querySnapshot?.documents{
                    if (snapShotDocument == []){
                        self.check = false;
                        self.show = false;
                        self.show2 = true
                        self.status = "user havent registered"
                    }
                    for doc in snapShotDocument{
                        let data = doc.data();
                        
                        if self.phone == data[FirestoreUser.phone] as! String{
                            self.check = true;
                            self.show = true;
                            self.show2 = false;
                            self.status = "already registered"
                            
                            break;
                        }
                        self.show2 = true;
                        self.status = "user havent registered";
                        
                    }
                    
                    
                }
                
                
                
            }
        }
        
        
        
        
        
        
    }
    
    
    public func startBottomSheet (){
        
        
        PhoneAuthProvider.provider().verifyPhoneNumber(phone, uiDelegate: nil ){ [self](verificationId, error) in
            
            if (error != nil){
                print ("cannot registered again")
                print (error?.localizedDescription);
                
                
            }else{
                show = true;
                print(verificationId);
                verifyId = verificationId;
                
                
            }
        }
        
    }
    
    public func login (){
//        print ("lewat login dulu")
//
//        var check = false;
//
//        if (phone != nil && verifyUser()){
//
//
//            PhoneAuthProvider.provider().verifyPhoneNumber(phone, uiDelegate: nil ){ [self](verificationId, error) in
//
//                if (error != nil){
//                    print ("cannot registered again")
//                    print (error?.localizedDescription);
//
//
//                }else{
//                    show = true;
//                    print(verificationId);
//                    verifyId = verificationId;
//
//
//                }
//            }
//        }else if (status == "user havent registered" && !verifyUser()){
//            self.show2 = true;
//        }else if (!verifyUser()){
//            show = false;
//            print ("phone number must not have been empty");
//
//        }
        
    }
    
    public func clickAlert () -> Bool{
        
        var check = false
        
        
        let credential = PhoneAuthProvider.provider().credential(withVerificationID: verifyId!, verificationCode : OTP)
        
        
        
        Auth.auth().signIn(with: credential) { (success, error) in
            if (error == nil){
//                print (success);
                
                self.sendToOtherScene = true;
                
                check = true;
                
                UserDefaults.standard.setValue(self.phone, forKey: "Phone")
//                print ("user sign in");
//                UserDefaults.standard.set (credential, forKey: "credential");
//
//                UserDefaults.standard.set (self.idDocument, forKey: "id");
                
            }else {
                self.sendToOtherScene = false;
                check = false;
                print ("something went wrong")
            }
        }
        
        return check;
    }
    
    
    
    
    
    
    
    
}
