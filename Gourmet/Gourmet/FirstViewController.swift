//
//  FirstViewController.swift
//  gourmet
//
//  Created by Alejandro Miragall Arnal on 15/3/16.
//  Copyright © 2016 Alejandro Miragall Arnal. All rights reserved.
//

import UIKit
import Firebase
import AlamofireImage

class FirstViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    
    @IBOutlet
    var tableView: UITableView!
    
    let restaurantRepository: RestaurantsRepository = RestaurantsRepository()
    
    var items: [Restaurant] = [Restaurant]()

    override func viewDidLoad() {
        super.viewDidLoad()
        let nib = UINib(nibName: "RestaurantTableViewCell", bundle: nil)
        tableView.registerNib(nib, forCellReuseIdentifier: RestaurantTableViewCell.name)
        getRestaurants()
       
    }
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "segueToRestaurantDetail" {
            let viewController = segue.destinationViewController as! RestaurantDetailViewController
            viewController.hidesBottomBarWhenPushed = true
            viewController.restaurant = sender as? Restaurant
        }
    }
    
    override func viewDidAppear(animated: Bool) {
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.items.count;
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell:RestaurantTableViewCell = self.tableView.dequeueReusableCellWithIdentifier(RestaurantTableViewCell.name) as! RestaurantTableViewCell
        let restaurant:Restaurant = self.items[indexPath.row]
        cell.loadItem(title: restaurant.name, image: restaurant.photo, completion: { cell.setNeedsLayout() })
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        performSegueWithIdentifier("segueToRestaurantDetail", sender: self.items[indexPath.row])
        print("You selected cell #\(indexPath.row)!")
    }
    
    func getRestaurants() {
        restaurantRepository.getRestaurants({
            self.items.appendContentsOf($0)
            dispatch_async(dispatch_get_main_queue(), {
                self.tableView.reloadData()
            })
        })
    }
}

