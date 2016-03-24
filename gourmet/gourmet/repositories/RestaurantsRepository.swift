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
    
    let restMapper: RestaurantMapper
    
    init() {
        restMapper = RestaurantMapper()
    }
    
    func getRestaurants(callback: [Restaurant] -> Void) {
        let firebase = Firebase(url: "https://tuenti-restaurants.firebaseio.com/restaurants")
        NSLog("Opening Resto")
        firebase.observeEventType(.Value,
            withBlock: { snapshot in
                var restaurants = [Restaurant]()
                for child in (snapshot.children.allObjects as? [FDataSnapshot])! {
                    let restaurant: Restaurant = self.restMapper.map(child)
                    restaurants.append(restaurant)
                }
                
                callback(restaurants)
        })
    }
}
