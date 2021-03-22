//
//  NewsView.swift
//  BliBliTestProject
//
//  Created by andre basra utama on 16/03/21.
//

import SwiftUI
import SDWebImageSwiftUI
import WebKit
import SwiftyJSON
struct NewsView: View {
    @ObservedObject var newsManager = NetworkManager()
    @State var x : CGFloat = 0
    @State var count : CGFloat = 0
    @State var screen = UIScreen.main.bounds.width - 30
    @State var counter = 0
    var edges = UIApplication.shared.windows.first?.safeAreaInsets;
    var body: some View {
        
            
            VStack(spacing : 0) {
                HStack{
                    Text("News")
                        .font(.largeTitle)
                        .fontWeight(.heavy)
                        .foregroundColor(.black)
                    Spacer (minLength: 0)
                    
                }.padding()
                .padding(.top, edges!.top)
                .background(Color.white)
                .shadow(color: Color.white.opacity(0.06), radius: 5, x: 0, y: 5 )
                
                
                Spacer(minLength: 10)
                
                if (!newsManager.NewsDatas.isEmpty){
                    
                        TabView {
                            ForEach(newsManager.NewsDatas){
                                i in
                                CardCarouselView(newsmodel: i)
                            }
                        }.tabViewStyle(PageTabViewStyle())
                        .clipShape(RoundedRectangle(cornerRadius: 5))
                        .padding ()
                        .frame (width: UIScreen.main.bounds.width - 30, height: 300)
                        .id(newsManager.NewsDatas.count)
                    
                }
                
                    
                
                    
                
                
                
//
////
//                ScrollView(.horizontal, showsIndicators :false){
//
//                    HStack(spacing : 15){
//                        ForEach(newsManager.NewsDatas){ i in
//                            CardCarouselView (newsmodel : i).onTapGesture{
//                                newsManager.show = true
//                                newsManager.urlPending = i.url
//                            }
//
//                        }
//                    }
//                }.frame (height : 300).padding(.top, -35).padding(.horizontal, 10)

                
                //--------------- ini kepisah --------------
                
                
//                HStack(spacing : 15){
//                    ForEach(newsManager.NewsDatas){ i in
//                        CardCarouselView (newsmodel : i)
//                            .offset (x : self.x+620)
//                            .highPriorityGesture (DragGesture ()
//                                                    .onChanged({(value) in
//
//                                                        if value.translation.width > 0{
//                                                            self.x = value.location.x
//                                                        }else {
//                                                            self.x = value.location.x - self.screen
//                                                        }
//
//                                                    })
//                                                    .onEnded({(value) in
//                                                        if value.translation.width > 0{
//                                                            if value.translation.width > ((screen - 80)/2) && Int (self.count)+1 != newsManager.getMiddleIndex()+1{
//                                                                self.count += 1
//                                                                self.x = (self.screen + 15) * self.count
//                                                            }else{
//                                                                self.x = (screen + 15) * self.count
//                                                            }
//                                                        }else{
//                                                            if -value.translation.width > ((screen - 80)/2) && -Int (self.count) != newsManager.getMiddleIndex(){
//                                                                self.count -= 1
//                                                                self.x = (self.screen + 10) * self.count
//                                                            }else{
//                                                                self.x = (screen + 10) * self.count
//                                                            }
//                                                        }
//                                                    })
//                            )
//                    }
//                }.shadow(color: Color.black.opacity(0.06), radius: 15 )
                
                
                
                
                List (newsManager.NewsEverything){i in
                    
                        HStack (spacing: 15){
                            VStack (alignment: .leading, spacing: 10, content: {
                                Text(i.title).fontWeight(.heavy)
                                Text(i.desc).lineLimit(2)
                            })
                            if (i.image != ""){
                                WebImage(url: URL(string: i.image)!, options: .highPriority, context: nil).frame (width: 110, height: 135).cornerRadius(20)
                                
                            }
                            
                            
                        }.onTapGesture {
                            newsManager.show = true;
                            newsManager.urlPending = i.url
                        }
                    
                    
                    
                    
                }.padding(.bottom, 5)
                
            }.edgesIgnoringSafeArea(.top).sheet(isPresented: $newsManager.show) {
                webView(url: newsManager.urlPending)
            }
            
        
    }
}

struct webView : UIViewRepresentable{
    var url : String
    func makeUIView(context: Context) -> WKWebView {
        let newsViewWeb = WKWebView()
        newsViewWeb.load(URLRequest(url: URL(string: url)!))
        return newsViewWeb;
    }
    func updateUIView(_ uiView: WKWebView, context: Context) {
        
    }
}



struct NewsView_Previews: PreviewProvider {
    static var previews: some View {
        NewsView()
    }
}



