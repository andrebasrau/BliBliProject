//
//  NetworkManager.swift
//  BliBliTestProject
//
//  Created by andre basra utama on 16/03/21.
//

import Foundation
import SwiftyJSON
class NetworkManager : ObservableObject {
    
    @Published var NewsDatas = [NewsData]()
    @Published var NewsEverything = [NewsData]()
    
    func getHeadLine (){
        let source = "https://newsapi.org/v2/top-headlines?sources=bbc-news&apiKey=80927641a04449b483307ebb07c9f515"
        
        let url = URL (string : source)!
        let session = URLSession (configuration: .default)
        let result = session.dataTask (with : url) { (data, response , error) in
            if error != nil{
                print (error!.localizedDescription)
                return
            }
            let json = try! JSON(data : data!)
            for i in json["articles"]{
                let title = i.1["title"].stringValue
                let description = i.1["description"].stringValue
                let url = i.1["url"].stringValue
                let image = i.1["urlToImage"].stringValue
                let id = i.1["publishedAt"].stringValue
                DispatchQueue.main.async{
                    self.NewsDatas.append(NewsData (id : id , title :title, desc : description, url : url , image : image))
                }
                
                
                
                
            }
        }
        result.resume()
    }
    
    func getEverything (){
        let source = "https://newsapi.org/v2/everything?sources=bbc-news&apiKey=80927641a04449b483307ebb07c9f515"
        
        let url = URL (string : source)!
        let session = URLSession (configuration: .default)
        let result = session.dataTask (with : url) { (data, response , error) in
            if error != nil{
                print (error!.localizedDescription)
                return
            }
            let json = try! JSON(data : data!)
            for i in json["articles"]{
                let title = i.1["title"].stringValue
                let description = i.1["description"].stringValue
                let url = i.1["url"].stringValue
                let image = i.1["urlToImage"].stringValue
                let id = i.1["publishedAt"].stringValue
                DispatchQueue.main.async{
                    self.NewsEverything.append(NewsData (id : id , title :title, desc : description, url : url , image : image))
                }
                
                
                
                
            }
        }
        result.resume()
        
    }
    
    func getMiddleIndex ()-> Int{
        return NewsEverything.count / 2;
    }
    
    
    init (){
        getHeadLine();
        getEverything();
    }
    
}


