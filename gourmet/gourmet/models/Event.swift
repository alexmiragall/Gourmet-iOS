//
//  Event.swift
//  gourmet
//
//  Created by Alejandro Miragall Arnal on 24/3/16.
//  Copyright © 2016 Alejandro Miragall Arnal. All rights reserved.
//

import Foundation

public class Event {
    var restaurant: Restaurant
    var date: Int
    var owner: User
    var comment: String?
    var occupants: [User]?
    
    init(restaurant: Restaurant, date: Int, owner: User, comment: String?, occupants: [User]?) {
        self.restaurant = restaurant
        self.date = date
        self.owner = owner
        self.comment = comment
        self.occupants = occupants
    }
}