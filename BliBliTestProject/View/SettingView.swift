//
//  SettingView.swift
//  BliBliTestProject
//
//  Created by andre basra utama on 15/03/21.
//

import SwiftUI

import SDWebImageSwiftUI

struct SettingView: View {
    @StateObject var settingView = SettingViewModel();
    var edges = UIApplication.shared.windows.first?.safeAreaInsets;
    
    @StateObject var profileView : ProfileViewModel;
    var body: some View {
        ZStack{
            VStack(spacing : 0){
                HStack{
                    Text("Setting")
                        .font(.largeTitle)
                        .fontWeight(.heavy)
                        .foregroundColor(.black)
                    Spacer (minLength: 0)
                    
                }.padding()
                .padding(.top, edges!.top)
                .background(Color.white)
                .shadow(color: Color.white.opacity(0.06), radius: 5, x: 0, y: 5 )
                ;
                
                Spacer(minLength: 10)
                
                
                VStack{
                    WebImage(url: URL(string: settingView.UserProfile.image))
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .foregroundColor(.black)
                        .frame (width: 115, height: 115)
                        .background(Color.black.opacity(0.05))
                        .clipShape(Circle())
                        .onTapGesture {
                            settingView.picker = true;
                        }
                    
                    VStack{
                        HStack{
                            Image(systemName: "phone.fill").foregroundColor(.black)
                            TextField("Input Your Phone", text: $profileView.UserProfile.phone).keyboardType(.numberPad).disabled(true);
                            
                            
                        }.padding().clipShape(Capsule())
                        
                    }.background(Color.white).cornerRadius(10.0).shadow(radius: 10 )
                    .padding(.top, 30);
                    VStack{
                        HStack{
                            Image(systemName: "person.fill").foregroundColor(.black)
                            TextField("\(settingView.UserProfile.username) (Use Last Username)", text: $settingView.Username).keyboardType(.numberPad);
                            
                            
                        }.padding().clipShape(Capsule())
                        
                    }.background(Color.white).cornerRadius(10.0).shadow(radius: 10 );
                    
                    VStack{
                        HStack{
                            Image(systemName: "calendar").foregroundColor(.black)
                            DatePicker(
                                "Birth Date",
                                selection: $settingView.date,
                                displayedComponents: [.date]
                            )
                            
                        }.padding().clipShape(Capsule())
                        
                    }.background(Color.white).cornerRadius(10.0).shadow(radius: 10 );
                    
                    HStack{
                        Button(action: {
                            withAnimation(.spring (response: 0.8 , dampingFraction: 0.5 , blendDuration: 0.5)){
                                settingView.index = 0;
                            }
                            
                        }) {
                            Text("Male").fontWeight(.bold).padding().frame(width: ((UIScreen.main.bounds.width - 59)/2) ).foregroundColor(settingView.index == 0 ? .white : .black)
                        }.background(settingView.index == 0 ? Color.blue : Color.clear).clipShape(Capsule())
                        
                        
                        Button(action: {
                                withAnimation(.spring (response: 0.8 , dampingFraction: 0.5 , blendDuration: 0.5)){
                                    settingView.index = 1;
                                }                    }) {
                            Text("Female").fontWeight(.bold).padding().frame(width: ((UIScreen.main.bounds.width - 59)/2) ).foregroundColor(settingView.index == 1 ? .white : .black)
                        }.background(settingView.index == 1 ? Color.blue : Color.clear).clipShape(Capsule())
                    }.clipShape(Capsule()).padding(.top, 30)
                  
                    
                    
                    Button(action: {
                        settingView.save();
                        profileView.sendToSetting = false;
                        
                    }, label: {
                        HStack{
                            Spacer()
                            Text("Save").foregroundColor(.white)
                                .padding(10)
                            Spacer()
                            
                            
                        }
                        
                    })
                    .background(Color.blue)
                    .cornerRadius(20)
                    .padding(.top, 30)
                    
                }.padding(.horizontal)
                
                
                
                Spacer();
                
                
                
                
                
                
                
            }
        }
        .background(Color.black.opacity(0.05)).edgesIgnoringSafeArea(.top)
        
        .navigationBarBackButtonHidden(true)
        .onAppear(){
            settingView.getUser ();
        }.onChange(of: settingView.img) { (Equatable) in
            settingView.updateProfile();
        }
        .sheet(isPresented: $settingView.picker, content: {
            Picker(pick: $settingView.picker, img: $settingView.img);
        })
        
        
    }
}

struct SettingView_Previews: PreviewProvider {
    static var previews: some View {
        
        var profileView1  = ProfileViewModel();
        SettingView(profileView : profileView1)
    }
}
