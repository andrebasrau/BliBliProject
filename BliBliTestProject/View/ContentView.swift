//
//  ContentView.swift
//  Project Bli Bli
//
//  Created by andre basra utama on 03/03/21.
//

import SwiftUI

struct ContentView: View {
    
    @StateObject var registerView = LoginPageViewModel()
    @StateObject var loginView = loginViewModel();

    
    
    var body: some View {
        
        NavigationView{
            ZStack{
                Color.init(red: 0.96, green: 0.98, blue: 0.98).ignoresSafeArea(.all)
                Spacer();
                
                Home(registerView: registerView, loginView: loginView);
                
                NavigationLink(
                    destination: HomeView( LoginView: loginView),
                    isActive: $loginView.sendToOtherScene,
                    label: {
                        Text("")
                    });
                
                
                VStack{
                    Spacer();
                    customeBottomSheet(loginView: loginView, registerView: registerView).offset(y : registerView.show || loginView.show || loginView.show2 ? CGFloat(0) : UIScreen.main.bounds.height);
                    
                }.background((loginView.show || registerView.show || loginView.show2 ? Color.black.opacity(0.3) : Color.clear).onTapGesture {
                    loginView.show = false;
                    registerView.show = false;
                    loginView.show2 = false;
                    registerView.onTap();
                })
              
                
            }.edgesIgnoringSafeArea(.all).animation(.default).onAppear(){
//                print (registerView.testUser());
                registerView.testUser();
            }
            
        }
        .onAppear{
//            registerView.testUser();
            loginView.AutoLogin  ();
//            print (UserDefaults.standard.string(forKey: "Phone")!)
        }
        
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

struct Home: View{
        
    var registerView : LoginPageViewModel;
    var loginView : loginViewModel;
    
    
    @State var index = 0;
    var body : some View{
        VStack{
            Image.init("logo").resizable().frame(width: 200, height: 200)
            
            HStack{
                Button(action: {
                    withAnimation(.spring (response: 0.8 , dampingFraction: 0.5 , blendDuration: 0.5)){
                        index = 0;
                    }
                    
                }) {
                    Text("Sign In").fontWeight(.bold).padding().frame(width: ((UIScreen.main.bounds.width - 59)/2) ).foregroundColor(index == 0 ? .white : .black)
                }.background(index == 0 ? Color.blue : Color.clear).clipShape(Capsule())
                
                
                Button(action: {
                        withAnimation(.spring (response: 0.8 , dampingFraction: 0.5 , blendDuration: 0.5)){
                            index = 1;
                        }                    }) {
                    Text("Register").fontWeight(.bold).padding().frame(width: ((UIScreen.main.bounds.width - 59)/2) ).foregroundColor(index == 1 ? .white : .black)
                }.background(index == 1 ? Color.blue : Color.clear).clipShape(Capsule())
            }.clipShape(Capsule()).padding(.top, 30)
            
            if (index == 0){
                VStack{
                    login(loginView: loginView).padding();
                    
                }
                
            }else{
                VStack{
                    
                    register(registerView: registerView).padding();
                    
                    
                }
            }
            
            
        }
        
        
    }
}


struct register : View{
    
    
    @StateObject var registerView : LoginPageViewModel;
    
    
    
    
    
    var body : some View{
        VStack{
            HStack{
                Image(systemName: "person.fill").foregroundColor(.white)
                TextField("Input Your Username", text: $registerView.username).foregroundColor(.white)
                
            }.padding().clipShape(Capsule())
            Divider().background(Color.white);
            
            
            HStack{
                Image(systemName: "phone.fill").foregroundColor(.white)
                TextField("Input Your Phone Number", text: $registerView.phone).foregroundColor(.white)
                
            }.padding().clipShape(Capsule());
            
            
        }.padding(.vertical, 20).background(Color.blue).cornerRadius(10.0);
        
        
        
        Button(action: {
            
           
            
            
            //untuk action ke register
            registerView.register();
            
            
        }) {
            Text("Register").fontWeight(.bold)
                .padding()
                .frame(width: ((UIScreen.main.bounds.width-50))).foregroundColor(.white)
        }.background(Color.blue).clipShape(Capsule())
        
        
    }
}

struct login : View{
    @StateObject var loginView : loginViewModel;
    
    
    var body : some View{
        
        VStack{
            HStack{
                Image(systemName: "phone.fill").foregroundColor(.white)
                TextField("Input Your Phone", text: $loginView.phone).foregroundColor(.white).keyboardType(.numberPad);
                
                
            }.padding().clipShape(Capsule())
            
        }.padding(.vertical, 20).background(Color.blue).cornerRadius(10.0);
        
        
        
        Button(action: {
            // untuk action ke login
            
            loginView.verifyUser();
            
        }) {
            Text("Login").fontWeight(.bold)
                .padding()
                .frame(width: ((UIScreen.main.bounds.width-50))).foregroundColor(.white)
        }.background(Color.blue).clipShape(Capsule())
        
        
        
    }
}



struct customeBottomSheet : View{
    
    @StateObject var loginView :
        loginViewModel;
    
    @StateObject var registerView : LoginPageViewModel;
    var body : some View{
        
        VStack(spacing : 15){
            
            if (loginView.show){
                customeBottomSheetLogin(loginView: loginView);
            };if (registerView.show){
                customeBottomSheetRegister (status: registerView.status);
            };if (loginView.show2){
                customeBottomSheetRegister(status: loginView.status);
            }
        }.padding(.bottom, 25).padding(.top, 25)
        .padding(.horizontal)
        .padding()
        .background(Color.white)
        .cornerRadius(25)
        .edgesIgnoringSafeArea(.bottom)
        
        
        
        
        
    }
    
}


struct customeBottomSheetLogin : View{
    
    @StateObject var loginView :
        loginViewModel;
    var body : some View{
        VStack(){
            
            Text("Input Your OTP Code")
            
            
            TextField("OTP CODE", text: $loginView.OTP)
            Button(action: {loginView.clickAlert()}, label: {
                Text("Button").fontWeight(.bold)
                    .padding()
                    .frame(width: ((UIScreen.main.bounds.width-50))).foregroundColor(.white)
            }).background(Color.blue).clipShape(Capsule())
            
            
        }.onAppear(){
            loginView.startBottomSheet();
        }
        
    }
}

struct customeBottomSheetRegister : View{
    var status : String ;
    
    var body : some View{
        VStack{
            
            Text(status).frame(width: UIScreen.main.bounds.width-50)
            
            
            
        }
    }
}

