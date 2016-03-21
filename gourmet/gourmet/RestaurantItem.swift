//
//  RestaurantItem.swift
//  gourmet
//
//  Created by Alejandro Miragall Arnal on 22/3/16.
//  Copyright © 2016 Alejandro Miragall Arnal. All rights reserved.
//

import MapKit
import UIKit

class RestaurantItem: NSObject, MKAnnotation {
    var title: String?
    var coordinate: CLLocationCoordinate2D
    var info: String?
    
    init(title: String?, coordinate: CLLocationCoordinate2D, info: String?) {
        self.title = title
        self.coordinate = coordinate
        self.info = info
    }
}