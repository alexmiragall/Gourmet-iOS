//
//  User.swift
//  gourmet
//
//  Created by Alejandro Miragall Arnal on 24/3/16.
//  Copyright © 2016 Alejandro Miragall Arnal. All rights reserved.
//

import Foundation

public struct User: JSONAble {
    //Optional for the moment
    var id: String?
    var name: String
    var photoUrl: String?
    
    init(id: String?, name: String, photoUrl: String?) {
        self.id = id
        self.name = name
        self.photoUrl = photoUrl
    }
}