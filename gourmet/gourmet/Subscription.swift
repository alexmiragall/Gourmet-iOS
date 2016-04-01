//
//  Subscription.swift
//  gourmet
//
//  Created by Alejandro Miragall Arnal on 1/4/16.
//  Copyright © 2016 Alejandro Miragall Arnal. All rights reserved.
//

import Foundation

func ==(lhs: Subscription, rhs: Subscription) -> Bool {
    if let lhsId = lhs.id,
        rhsId = rhs.id {
            return lhsId == rhsId
    }
    return false
}

public class Subscription: NSObject {
    let id: String?
    let restaurant: Restaurant
    let user: User
    let date: Double
    
    init(let id: String?,
        let restaurant: Restaurant,
        let user: User,
        let date: Double) {
            self.id = id
            self.restaurant = restaurant
            self.user = user
            self.date = date
    }
    
    convenience init(let restaurant: Restaurant
        , let user: User) {
            self.init(id: nil, restaurant: restaurant, user: user, date: NSDate.init().timeIntervalSince1970)
    }
}