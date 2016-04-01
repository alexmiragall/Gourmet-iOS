//
//  UserMapper.swift
//  gourmet
//
//  Created by Alejandro Miragall Arnal on 24/3/16.
//  Copyright © 2016 Alejandro Miragall Arnal. All rights reserved.
//

import Foundation
import Firebase

class UserMapper {
    
    func map(snapshot: FDataSnapshot) -> User {
        let name = snapshot.value.objectForKey("name") as! String
        let photoUrl = snapshot.value.objectForKey("photoUrl") as? String
        return User(name: name, photoUrl: photoUrl)
    }
    
    func mapInverse(user: User) -> Dictionary<String, AnyObject> {
        var dictionary = Dictionary<String, AnyObject>()
        dictionary["name"] = user.name
        dictionary["photoUrl"] = user.photoUrl
        return dictionary
    }
}