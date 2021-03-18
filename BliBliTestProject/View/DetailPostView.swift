//
//  DetailPostView.swift
//  BliBliTestProject
//
//  Created by andre basra utama on 17/03/21.
//

import SwiftUI

struct DetailPostView: View {
    @StateObject var PostDB : PostListViewModel;
    @StateObject var MessageDB = DetailViewModel ();
    var Post : PostItemModel
    
    @Environment(\.presentationMode) var presentationView;
    var body: some View {
        VStack{
            HStack(spacing : 15){
                Button(action: {
                    presentationView.wrappedValue.dismiss()
                    
                }) {
                    Text("X")
                        .fontWeight(.bold)
                        .foregroundColor(Color.blue)
                }
                Spacer (minLength: 0)
                
            }.padding();
            PostItemView(post: Post, postList: PostDB)
            
            Divider ();
            
            List(MessageDB.Chat){
                chat in
                
                ChatView (chatModel: chat)
            }
            HStack {
                TextField("test", text: $MessageDB.Message).lineLimit(0)
                Button {
                    MessageDB.sendMessage(id: Post.id)
                } label: {
                    Image (systemName : "paperplane")
                }

            }
        }.padding().onAppear(){
            MessageDB.getAllChat(id: Post.id)
        }
    }
}

struct DetailPostView_Previews: PreviewProvider {
    static var previews: some View {
        var PostDB1 = PostListViewModel ();
        var Post1 = PostItemModel(id: "", title: "", image: "", time: Date(), user: UserModel(username: "andre", phone: "08121269300", gender: "Male", image: ""), chat: [ChatModel(user: UserModel(username: "andre", phone: "08121269300", gender: "Male", image: ""), message: "", time: Date())]);
        DetailPostView(PostDB: PostDB1, Post: Post1)
    }
}
