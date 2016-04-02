//
//  UserRepository.swift
//  gourmet
//
//  Created by Alejandro Miragall Arnal on 2/4/16.
//  Copyright © 2016 Alejandro Miragall Arnal. All rights reserved.
//

import Foundation
import Firebase

public class UserRepository: Repository<User> {
    let userMapper: UserMapper
    var currentUser: User? {
        return user
    }
    private var user: User?
    
    override init() {
        userMapper = UserMapper()
    }
    
    override func getUrl() -> String {
        return "https://tuenti-restaurants.firebaseio.com/users"
    }
    
    override func map(snapshot: FDataSnapshot) -> User {
        return userMapper.map(snapshot)
    }
    
    public func setCurrentUser(user: User, callback: (error: Bool) -> Void) {
        let firebase = getConnection()
        firebase.childByAppendingPath(user.id).setValue(userMapper.mapInverse(user), withCompletionBlock: {
            (error, firebase) in
                if (error == nil) {
                    self.user = user
                    callback(error: false)
                } else {
                    callback(error: true)
                }
        })
    }
}