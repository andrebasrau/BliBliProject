//
//  PostView.swift
//  Project Bli Bli
//
//  Created by andre basra utama on 11/03/21.
//

import SwiftUI

struct PostViewList: View {
    var edges = UIApplication.shared.windows.first?.safeAreaInsets;
    @StateObject var postDB = PostListViewModel ();
    
    
    
    
    var body: some View {
        
        
        
            
            
            ZStack{
                VStack{
                    HStack{
                        Text("Forum")
                            .font(.largeTitle)
                            .fontWeight(.heavy)
                            .foregroundColor(.black)
                        Spacer (minLength: 0)
                        
                    }.padding()
                    .padding(.top, edges!.top)
                    .background(Color.black.opacity(0.05))
                    .shadow(color: Color.white.opacity(0.06), radius: 5, x: 0, y: 5 )
                    
                    if (postDB.posts.isEmpty){
                        Spacer (minLength: 0);
                        
                        if (postDB.isPostEmpty){
                            Text("No Post yet !!")
                        }else{
                            ProgressView();
                        }
                        Spacer(minLength : 0);
                        
                        
                    }else{
                        
                        
                        ScrollView {
                            VStack(spacing : 15){
                                ForEach(postDB.posts){post in
                                    
                                    
                                        PostItemView(post: post, postList: postDB)
                                            .onTapGesture{
                                                postDB.Move = true;
                                                postDB.PostPending = post
                                            }
                                    
                                    
                                    
                                }
                                
                            }.padding ()
                            
                        }
                        
                        
                    }
                    
                }
                .onAppear(){
                    postDB.getAllPosts();
                }
                
            }.fullScreenCover(isPresented: $postDB.Move) {
                DetailPostView(PostDB: postDB, Post: postDB.PostPending)
            }
            VStack{
                Spacer();
                HStack{
                    Spacer();
                    Button (action: {
                        print ("is clicked")
                        postDB.newPost.toggle();
                    }) {
                        Image (systemName: "plus.circle.fill")
                            .resizable()
                            .frame(width: 50, height: 50)
                            .foregroundColor(Color.blue)
                            .shadow(color: .blue, radius: 0.3, x: 1, y: 1 )
                        
                    }
                }.padding()
            }.fullScreenCover(isPresented: $postDB.newPost) {
                NewPostView(id : postDB.idForUpdate);
            }
            
        
        
    }
}

struct PostView_Previews: PreviewProvider {
    static var previews: some View {
        PostViewList()
    }
}
