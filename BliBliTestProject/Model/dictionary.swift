//
//  dictionary.swift
//  Project Bli Bli
//
//  Created by andre basra utama on 05/03/21.
//

import Foundation



struct FirestoreUser{
    static let id = "id"
    static let username = "username";
    static let phone = "phone"
    static let date = "date";
    static let gender = "gender";
    static let img = "image";
}

struct FirestorePost {
    static let id = "id"
    static let headTitle = "HeadTitle"
    static let title = "Title"
    static let time = "Time"
    static let image = "Image"
    static let user = "User"
    static let chat = "Chat"
}

struct FirestoreMessage {
    static let user = "User"
    static let message = "Message"
    static let time = "Time"
}

//let title = doc.document.data()["Title"] as! String
//let time = doc.document.data()["Time"] as! Date;
//let image = doc.document.data()["Image"] as! String;
//let user = doc.document.data()["User"] as! DocumentReference
//
