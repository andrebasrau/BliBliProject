//
//  PostItem.swift
//  Project Bli Bli
//
//  Created by andre basra utama on 10/03/21.
//

import SwiftUI
import SDWebImageSwiftUI

struct PostItemView: View {
    
    var post : PostItemModel
    @ObservedObject var postList : PostListViewModel;
    var body: some View {
        VStack(spacing : 10){
            HStack{
                WebImage(url: URL(string: post.user.image))
                    .resizable()
                    .aspectRatio (contentMode : .fill)
                    .frame(width : 50 , height : 50)
                    .clipShape (Circle());
                
                
                Text (post.user.username)
                    .foregroundColor(.blue)
                    .fontWeight(.bold)
                
                Spacer (minLength: 0)
                if (UserDefaults.standard.string(forKey: "Phone")! == post.user.phone){
                    Menu(content: {
                        
                        Button(action: {postList.edit(id: post.id)}, label: {
                            Text("Edit")
                        })
                        
                        Button(action: {postList.delete(id: post.id)}, label: {
                            Text ("Delete")
                        })
                        
                        
                        
                        
                    }) {
                        Image (systemName: "ellipsis").renderingMode(.template)
                            .resizable().foregroundColor(.blue).frame(width: UIScreen.main.bounds.width/10, height: UIScreen.main.bounds.height/100)
                    }
                }
               
            }
            
            Divider();
            //mulai lagi disini
            if (post.image != ""){
                WebImage (url: URL(string : post.image))
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: UIScreen.main.bounds.width - 50, height: 200)
                    .cornerRadius(15)
            }
            HStack{
                Text(post.title)
                    .fontWeight(.bold)
                    .foregroundColor(.black)
                Spacer(minLength: 0)
            }.padding(.top, 5)
            
            HStack{
                
                Spacer (minLength: 0)
                
                Text(post.time, style: .time)
                    .font(.caption)
                    .fontWeight(.bold)
                    .foregroundColor(Color.black.opacity(0.06))
                Spacer(minLength: 0)
            }
            
        }.padding()
        .background(Color.white)
        .cornerRadius(15)
        
    }
}

//struct PostItem_Previews: PreviewProvider {
//    static var previews: some View {
//        PostItemView()
//    }
//}
