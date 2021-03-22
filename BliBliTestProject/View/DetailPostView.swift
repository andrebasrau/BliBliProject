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
    @State var didStartEditing = false;
    
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
                MultilineTextView(text: $MessageDB.Message, didStartEditing: $didStartEditing).frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: 44.0)
                    .onTapGesture{
                        didStartEditing = true;
                    }
                
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
        var Post1 = PostItemModel(id: "", headTitle: "", title: "", image: "", time: Date(), user: UserModel(username: "andre", phone: "08121269300", gender: "Male", image: ""), chat: [ChatModel(user: UserModel(username: "andre", phone: "08121269300", gender: "Male", image: ""), message: "", time: Date())]);
        DetailPostView(PostDB: PostDB1, Post: Post1)
    }
}


struct MultilineTextView : UIViewRepresentable{
    @Binding var text:String
    @Binding var didStartEditing : Bool
    
    func makeUIView(context: Context) -> UITextView {
        let view = UITextView()
        view.isScrollEnabled = true
        view.isEditable = true
        view.isUserInteractionEnabled = true
        view.delegate = context.coordinator
        
        return view;
    }
    
    func updateUIView(_ uiView: UITextView, context: Context) {
        if didStartEditing {
                
                uiView.textColor = UIColor.black
                uiView.text = text
                
            }
            else {
                uiView.text = "Input Text"
                uiView.textColor = UIColor.lightGray
            }
            
            uiView.font = UIFont.preferredFont(forTextStyle: .body)
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator($text)
    }
     
    class Coordinator: NSObject, UITextViewDelegate {
        var text: Binding<String>
     
        init(_ text: Binding<String>) {
            self.text = text
        }
     
        func textViewDidChange(_ textView: UITextView) {
            self.text.wrappedValue = textView.text
        }
    }
}
