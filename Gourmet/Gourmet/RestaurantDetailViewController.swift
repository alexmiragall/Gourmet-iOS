//
//  RestaurantDetailViewController.swift
//  gourmet
//
//  Created by Alejandro Miragall Arnal on 15/3/16.
//  Copyright © 2016 Alejandro Miragall Arnal. All rights reserved.
//

import UIKit
import Firebase

class RestaurantDetailViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        loadRestaurant()
    }
    
    override func viewDidAppear(animated: Bool) {
        //self.tabBarController?.tabBar.hidden = true
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func loadRestaurant() {
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
        })
        
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
