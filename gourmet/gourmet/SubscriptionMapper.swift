//
//  SubscriptionMapper.swift
//  gourmet
//
//  Created by Alejandro Miragall Arnal on 1/4/16.
//  Copyright © 2016 Alejandro Miragall Arnal. All rights reserved.
//

import Foundation
import Firebase

public class SubscriptionMapper {
    let userMapper: UserMapper
    let restaurantMapper: RestaurantMapper
    
    init() {
        userMapper = UserMapper()
        restaurantMapper = RestaurantMapper()
    }
    
    func map(snapshot: FDataSnapshot) -> Subscription {
        let id = snapshot.key
        let restaurant = restaurantMapper.map(snapshot.childSnapshotForPath("restaurant") as FDataSnapshot)
        let user = userMapper.map(snapshot.childSnapshotForPath("user") as FDataSnapshot)
        let date = snapshot.value.objectForKey("date") as! Double
        return Subscription(id: id, restaurant: restaurant, user: user, date: date)
    }
    
    func mapInverse(subscription: Subscription) -> Dictionary<String, AnyObject> {
        var dictionary = Dictionary<String, AnyObject>()
        dictionary["restaurant"] = restaurantMapper.mapInverse(subscription.restaurant)
        dictionary["user"] = userMapper.mapInverse(subscription.user)
        dictionary["date"] = subscription.date
        return dictionary
    }
}
