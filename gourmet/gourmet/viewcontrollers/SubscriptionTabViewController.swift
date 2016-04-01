//
//  SubscriptionTabViewController.swift
//  gourmet
//
//  Created by Alejandro Miragall Arnal on 1/4/16.
//  Copyright © 2016 Alejandro Miragall Arnal. All rights reserved.
//

import Foundation
import UIKit

class SubscriptionTabViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, RepositoryCallback {
    
    @IBOutlet
    var tableView: UITableView!
    
    let subscriptionRepository: SubscriptionsRepository = SubscriptionsRepository()
    
    var subscriptions: [Subscription] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        subscriptionRepository.registerMySubscriptions(self)
        let nib = UINib(nibName: "RestaurantTableViewCell", bundle: nil)
        tableView.registerNib(nib, forCellReuseIdentifier: RestaurantTableViewCell.name)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.subscriptions.count;
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell:RestaurantTableViewCell = self.tableView.dequeueReusableCellWithIdentifier(RestaurantTableViewCell.name) as! RestaurantTableViewCell
        let subscription: Subscription = self.subscriptions[indexPath.row]
        cell.loadItem(title: subscription.restaurant.name!, image: subscription.restaurant.photo, completion: { cell.setNeedsLayout() })
        return cell
    }
    
    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == UITableViewCellEditingStyle.Delete {
            subscriptionRepository.removeItem(subscriptions[indexPath.row])
        } else {
        }
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        print("You selected cell #\(indexPath.row)!")
    }
    
    func addedItem<T>(item: T) {
        self.subscriptions.append(item as! Subscription)
        //self.tableView.reloadData()
        tableView.insertRowsAtIndexPaths([NSIndexPath(forRow: subscriptions.count - 1, inSection: 0)], withRowAnimation: UITableViewRowAnimation.Bottom)
    }
    
    func removedItem<T>(item: T) {
        if let index = self.subscriptions.indexOf({ $0.id == (item as! Subscription).id} ) {
            self.subscriptions.removeAtIndex(index)
            tableView.deleteRowsAtIndexPaths([NSIndexPath(forRow: index, inSection: 0)], withRowAnimation: UITableViewRowAnimation.Fade)
        }
    }
}

