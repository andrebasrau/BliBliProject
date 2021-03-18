//
//  profileView.swift
//  BliBliTestProject
//
//  Created by andre basra utama on 15/03/21.
//

import SwiftUI
import SDWebImageSwiftUI

struct profileView: View {
    @StateObject var LoginView : loginViewModel;
    
    @StateObject var profileView = ProfileViewModel();
    var edges = UIApplication.shared.windows.first?.safeAreaInsets;
    var body: some View {
        NavigationView{
            ZStack{
                WebImage(url: URL(string: profileView.UserProfile.image))
                    .resizable()
                    .aspectRatio(
                        contentMode: .fill)
                    .frame(width: UIScreen.main.bounds.width, alignment: .center)
                
                
                
                VStack{
                    HStack{
                        Text("Profile")
                            .font(.largeTitle)
                            .fontWeight(.heavy)
                            .foregroundColor(.black)
                        Spacer (minLength: 0)
                        
                    }.padding()
                    .padding(.top, edges!.top)
                    .background(Color.white)
                    .shadow(color: Color.white.opacity(0.06), radius: 5, x: 0, y: 5 )
                    
                    Spacer()
                    NavigationLink(
                        destination: SettingView(profileView : profileView),
                        isActive:$profileView.sendToSetting,
                        label: {
                            Text("")
                        })
                    bottomProfile(profileView: profileView, LoginView: LoginView).padding(.bottom, 25)
                    
                
                    
                }
                
                
                
                
                
                
            }.background(Color.black.opacity(0.05)).edgesIgnoringSafeArea(.top)
            .onAppear(){
                
                
                profileView.getUser();
            }
            
        }
        
    }
}


struct bottomProfile : View{
    @StateObject var profileView : ProfileViewModel;
    @StateObject var LoginView : loginViewModel;
    var body : some View {
        
        ZStack{
            VStack(spacing : 10){
                HStack{
                    Text(profileView.UserProfile.username)
                        .font(.title2).bold()
                        .multilineTextAlignment(.leading)
                    
                    Spacer ();
                }
                HStack{
                    Text(profileView.UserProfile.phone).font(.caption).foregroundColor(.blue).bold()
                    Spacer();
                }
                
                HStack{
                    Text(profileView.UserProfile.gender!).font(.caption)
                    Spacer();
                }
                
                
                
                
                Button(action: {
                    profileView.sendToSetting = true;
                }, label: {
                    HStack{
                        Spacer()
                        Text("Setting").foregroundColor(.black)
                            .padding(10)
                        Spacer()
                        
                        
                    }
                    
                })
                .background(Color.black.opacity(0.05))
                .cornerRadius(20)
                
                
                Button(action: {
                    profileView.signOut();
                    LoginView.sendToOtherScene = false;
                    
                }, label: {
                    HStack{
                        Spacer()
                        Text("Sign Out").foregroundColor(.white)
                            .padding(10)
                        Spacer()
                        
                        
                    }
                    
                })
                .background(Color.blue)
                .cornerRadius(20)
                
                
                
                
            }
            .padding(.horizontal, 35)
            .padding(.vertical, 20)
            .background(Color.white)
            .cornerRadius(20)
            
        }.padding()
        
        
    }
}

struct profileView_Previews: PreviewProvider {
    static var previews: some View {
        var LoginView1 = loginViewModel();
        profileView(LoginView: LoginView1)
    }
}
