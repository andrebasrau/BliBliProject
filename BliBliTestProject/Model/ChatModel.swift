//
//  ChatModel.swift
//  BliBliTestProject
//
//  Created by andre basra utama on 17/03/21.
//

import Foundation

struct ChatModel : Identifiable{
    var id : String{
        return "\(user.username)\(time)"
    }
    var user : UserModel;
    var message : String
    var time : Date;
}
