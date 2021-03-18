//
//  Picker.swift
//  Project Bli Bli
//
//  Created by andre basra utama on 12/03/21.
//

import Foundation
import PhotosUI
import SwiftUI

struct Picker : UIViewControllerRepresentable {
    
    @Binding var pick : Bool;
    @Binding var img : Data;
    
  
    func makeUIViewController(context: Context) -> PHPickerViewController {
        var config = PHPickerConfiguration ();
        config.selectionLimit = 1;
        let controller = PHPickerViewController (configuration : config);
        
        controller.delegate = context.coordinator;
        return controller;
    }
    
    func makeCoordinator() -> Coordinator {
        return Picker.Coordinator (parent: self);
    }
    
    
  
    func updateUIViewController (_ uiViewController : PHPickerViewController, context : Context){
        
    }
    class Coordinator : NSObject,PHPickerViewControllerDelegate {
        var parent : Picker;
        
        init (parent : Picker){
            self.parent = parent
            
        }
        
        func picker (_ pciker : PHPickerViewController, didFinishPicking results: [PHPickerResult]){
            if (results.isEmpty){
                self.parent.pick.toggle();
                return
            }
            let item = results.first!.itemProvider;
            
            if item.canLoadObject(ofClass: UIImage.self){
                
                if item.canLoadObject(ofClass: UIImage.self){
                    item.loadObject(ofClass: UIImage.self) { (image, error) in
                        if error != nil {return}
                        let imageData = image as! UIImage;
                        DispatchQueue.main.async {
                            
                            self.parent.img = imageData.jpegData(compressionQuality: 0.5)!
                                self.parent.pick.toggle();
                            
                        }
                    }
                    
                }
                
            }
        }
    }
    
}
