//
//  RestaurantMapper.swift
//  gourmet
//
//  Created by Alejandro Miragall Arnal on 24/3/16.
//  Copyright © 2016 Alejandro Miragall Arnal. All rights reserved.
//

import Foundation
import Firebase

class RestaurantMapper {
    func map(snapshot: FDataSnapshot) -> Restaurant {
        let restaurant: Restaurant = Restaurant()
        restaurant.name = snapshot.value.objectForKey("name") as? String
        restaurant.description = snapshot.value.objectForKey("description") as? String
        restaurant.address = snapshot.value.objectForKey("address") as? String
        restaurant.photo = snapshot.value?.objectForKey("photo") as? String
        restaurant.lat = snapshot.value?.objectForKey("lat") as? Double
        restaurant.lon = snapshot.value?.objectForKey("lon") as? Double
        return restaurant
    }
    
    func mapInverse(restaurant: Restaurant) -> Dictionary<String, AnyObject> {
        var dictionary = Dictionary<String, AnyObject>()
        dictionary["name"] = restaurant.name
        dictionary["description"] = restaurant.description
        dictionary["address"] = restaurant.address
        dictionary["photo"] = restaurant.photo
        dictionary["lat"] = restaurant.lat
        dictionary["lon"] = restaurant.lon
        return dictionary
    }
}