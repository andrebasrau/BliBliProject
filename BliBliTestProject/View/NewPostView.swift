//
//  NewPostView.swift
//  Project Bli Bli
//
//  Created by andre basra utama on 11/03/21.
//

import SwiftUI

struct NewPostView: View {
    @StateObject var newPostViewModel = NewPostViewModel();
    @State var title = "";
    var id : String;
    
    @Environment(\.presentationMode) var presentationView;
    var body: some View {
        VStack{
            HStack(spacing : 15){
                Button(action: {
                    presentationView.wrappedValue.dismiss()
                    
                }) {
                    Text("Cancel")
                        .fontWeight(.bold)
                        .foregroundColor(Color.blue)
                }
                Spacer (minLength: 0)
                
                Button(action: {newPostViewModel.pickImage = true}) {
                    Image (systemName: "photo.fill")
                        .font(.title)
                        .foregroundColor(Color.blue)
                    
                    
                }
                
                Button(action: {newPostViewModel.Post(idForUpdate: id);
                    if (newPostViewModel.posting == true){
                        presentationView.wrappedValue.dismiss();
                    }
                    
                }) {
                    Text("Post")
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                        .padding(.vertical)
                        .padding(.horizontal, 25)
                        .background(Color.blue)
                        .clipShape(Capsule())
                    
                }
            }.padding();
            if newPostViewModel.img.count != 0 {
                
                ZStack(alignment : Alignment(horizontal : .trailing , vertical : .top)){
                    Image(uiImage : UIImage (data: newPostViewModel.img)!)
                        .resizable()
                        .aspectRatio(contentMode : .fill)
                        .frame(width : UIScreen.main.bounds.width / 2, height : 150)
                        .cornerRadius(15)
                    
                    
                    Button(action: {newPostViewModel.img = Data(count : 0)}){
                        Image (systemName : "xmark")
                            .foregroundColor (.white)
                            .padding (10)
                            .background(Color.blue)
                            .clipShape (Capsule ())
                    }
                        
                    
                    
                }.padding ()
                
            }
            TextField("input judul", text: $newPostViewModel.title).padding().background(Color.white)
            
            TextEditor(text: $newPostViewModel.postText).padding();
            
            
            
        }.background(Color.black.opacity(0.05).ignoresSafeArea(.all, edges: .all))
        .sheet(isPresented: $newPostViewModel.pickImage, content: {
            Picker(pick: $newPostViewModel.pickImage, img: $newPostViewModel.img)
        })
    }
}

