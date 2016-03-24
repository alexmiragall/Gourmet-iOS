//
//  User.swift
//  gourmet
//
//  Created by Alejandro Miragall Arnal on 24/3/16.
//  Copyright © 2016 Alejandro Miragall Arnal. All rights reserved.
//

import Foundation

public class User {
    var name: String
    var photoUrl: String?
    
    init(name: String, photoUrl: String?) {
        self.name = name
        self.photoUrl = photoUrl
    }
}