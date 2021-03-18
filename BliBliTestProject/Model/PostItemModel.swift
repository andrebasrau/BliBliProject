//
//  PostItemModel.swift
//  Project Bli Bli
//
//  Created by andre basra utama on 10/03/21.
//

import Foundation

struct PostItemModel : Identifiable {
    
    var id : String;
    var title : String;
    var image : String;
    var time : Date
    var user : UserModel
    var chat : [ChatModel]
}
