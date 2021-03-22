//
//  HomeView.swift
//  Project Bli Bli
//
//  Created by andre basra utama on 08/03/21.
//

import SwiftUI

struct HomeView: View {
    @State var page = 0;
    @StateObject var LoginView : loginViewModel;
    var body: some View {
        
        VStack(spacing: 0){
            ZStack{
                if (page == 0){
                    PostViewList().padding(.bottom, 30)
                }else if (page == 1){
                    SearchingView().padding(.bottom, 30)
                    
                }else if (page == 2){
                    NewsView().padding(.bottom, 30)
                }
                
                else if (page == 3){
                    profileView(LoginView : LoginView).padding(.bottom, 30);
                }
                
            }.padding(.bottom, -35)
            
            bottomNavigation(page: $page);
        }.navigationBarBackButtonHidden(true).navigationTitle("").navigationBarHidden(true)
        .background(Color.black.opacity(0.05)).edgesIgnoringSafeArea(.top)
        
    }
}

struct bottomNavigation : View{
    @Binding var page : Int
    
    var body : some View{
        HStack {
            Button(action: {
                page = 0;
                
            }, label: {
                Image(systemName: "house.fill")
            }).foregroundColor (Color.black.opacity(page == 0 ? 1 : 0.1))
            
            Spacer();
            
            Button(action: {
                page = 1;
            }, label: {
                Image(systemName: "magnifyingglass")
            }).foregroundColor (Color.black.opacity(page == 1 ? 1 : 0.1))
            
            Spacer();
            
            Button(action: {
                page = 2;
            }, label: {
                Image(systemName: "safari.fill")
            }).foregroundColor(Color.black.opacity(page == 2 ? 1 : 0.1))
            
            Spacer();
            
            Button(action: {
                page = 3;
            }, label: {
                Image(systemName: "person.fill")
            }).foregroundColor (Color.black.opacity(page == 3 ? 1 : 0.1))
//
        }.padding(.horizontal, 35)
        .padding(.vertical, 20)
        .background(Color.white)
        .cornerRadius(20)
        
        
        
    }
    
    
}
struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        
        var LoginView1 = loginViewModel();
        HomeView(LoginView: LoginView1)
    }
}


