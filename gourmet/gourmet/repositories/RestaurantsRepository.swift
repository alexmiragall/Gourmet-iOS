//
//  RestaurantsRepository.swift
//  gourmet
//
//  Created by Alejandro Miragall Arnal on 21/3/16.
//  Copyright © 2016 Alejandro Miragall Arnal. All rights reserved.
//

import Foundation
import Firebase

class RestaurantsRepository {
    
    init() {
    }
    
    func getRestaurants(callback: [Restaurant] -> Void) {
        let firebase = Firebase(url: "https://tuenti-restaurants.firebaseio.com/restaurants")
        NSLog("Opening Resto")
        firebase.observeEventType(.Value,
            withBlock: { snapshot in
                var restaurants = [Restaurant]()
                for child in (snapshot.children.allObjects as? [FDataSnapshot])! {
                    let restaurant: Restaurant = Restaurant()
                    restaurant.name = child.value.objectForKey("name") as? String
                    restaurant.description = child.value.objectForKey("description") as? String
                    restaurant.address = child.value.objectForKey("address") as? String
                    restaurant.photo = child.value?.objectForKey("photo") as? String
                    restaurant.lat = child.value?.objectForKey("lat") as? Double
                    restaurant.lon = child.value?.objectForKey("lon") as? Double
                    restaurants.append(restaurant)
                }
                
                callback(restaurants)
        })
    }
}
