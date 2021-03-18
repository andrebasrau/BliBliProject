//
//  ChatView.swift
//  BliBliTestProject
//
//  Created by andre basra utama on 18/03/21.
//

import SwiftUI
import SDWebImageSwiftUI
struct ChatView: View {
    var chatModel :ChatModel
    
    var body: some View {
        HStack{
            VStack{
                WebImage(url: URL(string: chatModel.user.image))
                    .resizable()
                    .aspectRatio (contentMode : .fill)
                    .frame(width : 30 , height : 30)
                    .clipShape (Circle());
                Spacer();
            }
            
            VStack{
                HStack{
                    Text(chatModel.user.username).bold().font(.caption).multilineTextAlignment(.leading)
                    Spacer()
                }
                
                HStack{
                    Text(chatModel.message).multilineTextAlignment(.leading)
                    Spacer()
                }
                
            }
            Spacer()
        }
        
    }
}

struct ChatView_Previews: PreviewProvider {
    static var previews: some View {
        var chatModel1 = ChatModel(user: UserModel(username: "", phone: "", gender: "", image: ""), message: "", time: Date())
        ChatView(chatModel: chatModel1)
    }
}
