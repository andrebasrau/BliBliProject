//
//  SearchingView.swift
//  BliBliTestProject
//
//  Created by andre basra utama on 22/03/21.
//

import SwiftUI

struct SearchingView: View {
    @StateObject var postListView = PostListViewModel()
    var edges = UIApplication.shared.windows.first?.safeAreaInsets;
    
    var body: some View {
        NavigationView {
            VStack{
                
                ZStack{
                    if (postListView.searchText == ""){
                        Text("Find various \(Text("FORUMS ").foregroundColor(.blue).font(.largeTitle).bold())in the \(Text("WORLD ").foregroundColor(.blue).font(.largeTitle).bold()) in your hands").bold().font(.largeTitle).padding().padding(.bottom, -50)
                        
                    }
                    
                    
                    VStack {
                        HStack{
                            Text("Searching")
                                .font(.largeTitle)
                                .fontWeight(.heavy)
                                .foregroundColor(.black)
                            Spacer (minLength: 0)
                            
                        }.padding()
                        .padding(.top, edges!.top)
                        .background(Color.white)
                        .shadow(color: Color.white.opacity(0.06), radius: 5, x: 0, y: 5 )
                        
                        
                        HStack{
                            TextField ("Searching", text: $postListView.searchText)
                            if (postListView.searchText != ""){
                                Button {
                                    postListView.searchText = ""
                                } label: {
                                    Image (systemName: "xmark")
                                }
                                
                            }
                        }.padding()
                            
                            
                            
                            if (postListView.searchText != ""){
                                if (postListView.posts.isEmpty){
                                    Spacer (minLength: 0);
                                    
                                    if (postListView.isPostEmpty){
                                        Text("No Post yet !!")
                                    }else{
                                        ProgressView();
                                    }
                                    Spacer(minLength : 0);
                                    
                                    
                                }else{
                                    
                                    
                                    ScrollView {
                                        VStack(spacing : 15){
                                            ForEach(postListView.posts.filter{$0.title.lowercased().contains(postListView.searchText.lowercased())
                                            }){post in
                                                
                                                
                                                PostItemView(post: post, postList: postListView)
                                                    .onTapGesture{
                                                        postListView.Move = true;
                                                        postListView.PostPending = post
                                                    }
                                                
                                                NavigationLink(
                                                    destination: DetailPostView(PostDB: postListView, Post: postListView.PostPending),
                                                    isActive: $postListView.Move,
                                                    label: {
                                                        Text("")
                                                    });
                                                
                                                
                                                
                                            }
                                            
                                        }.padding ()
                                        
                                    }
                                }
                                
                                
                            }
                            
                            
                        Spacer();
                            
                            
                        
                    }.onAppear(){
                        if (postListView.update == false){
                            postListView.getAllPosts()
                        }
                        
                    }.fullScreenCover(isPresented: $postListView.Move) {
                        DetailPostView(PostDB: postListView, Post: postListView.PostPending)
                    }

                }


            }.navigationTitle("").navigationBarHidden(true).edgesIgnoringSafeArea(.top)
                        
        }
    }
}

struct SearchingView_Previews: PreviewProvider {
    static var previews: some View {
        SearchingView()
    }
}

