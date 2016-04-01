//
//  RestaurantsRepository.swift
//  gourmet
//
//  Created by Alejandro Miragall Arnal on 21/3/16.
//  Copyright © 2016 Alejandro Miragall Arnal. All rights reserved.
//

import Foundation
import Firebase

public class RestaurantsRepository: Repository<Restaurant> {
    
    var restMapper: RestaurantMapper
    
    override init() {
        restMapper = RestaurantMapper()
    }
    
    override func getUrl() -> String {
        return "https://tuenti-restaurants.firebaseio.com/restaurants"
    }
    
    override func map(snapshot: FDataSnapshot) -> Restaurant? {
        return restMapper.map(snapshot)
    }
}
