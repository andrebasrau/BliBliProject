//
//  CardCarouselView.swift
//  BliBliTestProject
//
//  Created by andre basra utama on 17/03/21.
//

import SwiftUI
import SDWebImageSwiftUI
struct CardCarouselView: View {
    var newsmodel : NewsData
    var body: some View {
        VStack(){
            WebImage(url: URL(string: newsmodel.image))
                .resizable ().frame(width: UIScreen.main.bounds.width-30, height : 200)
            
            VStack {
                
                Text(newsmodel.title)
                    .fontWeight(.bold)
                    .padding(.vertical, 13)
                    .frame(width: UIScreen.main.bounds.width-30)
                    .foregroundColor(Color.white)
                    .lineLimit(1)
            }.background(Color.black.opacity(0.5))
            
        }.cornerRadius(25).frame( height: 50).shadow(radius: 5)
    }
}

struct CardCarouselView_Previews: PreviewProvider {
    static var previews: some View {
        var newsModel1 = NewsData(id: "", title: "", desc: "", url: "", image: "")
        CardCarouselView(newsmodel: newsModel1)
    }
}
