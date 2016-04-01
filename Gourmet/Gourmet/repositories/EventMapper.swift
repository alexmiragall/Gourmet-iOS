//
//  EventMapper.swift
//  gourmet
//
//  Created by Alejandro Miragall Arnal on 24/3/16.
//  Copyright © 2016 Alejandro Miragall Arnal. All rights reserved.
//

import Foundation
import Firebase


class EventMapper {
    let restMapper: RestaurantMapper
    let userMapper: UserMapper
    
    init() {
        restMapper = RestaurantMapper()
        userMapper = UserMapper()
    }
    
    func map(snapshot: FDataSnapshot) -> Event {
        let restaurantSnapshot = snapshot.childSnapshotForPath("restaurant") as FDataSnapshot
        let restaurant = restMapper.map(restaurantSnapshot)
        let date: Double = snapshot.value.objectForKey("date") as! Double
        let owner: User = userMapper.map(snapshot.childSnapshotForPath("owner") as FDataSnapshot)
        let comment: String? = snapshot.value.objectForKey("comment") as? String
        
        let event: Event = Event(restaurant: restaurant, date: date, owner: owner, comment: comment, occupants: nil)
        return event
    }
}