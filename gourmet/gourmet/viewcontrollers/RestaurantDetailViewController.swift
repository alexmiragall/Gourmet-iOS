//
//  RestaurantDetailViewController.swift
//  gourmet
//
//  Created by Alejandro Miragall Arnal on 15/3/16.
//  Copyright © 2016 Alejandro Miragall Arnal. All rights reserved.
//

import UIKit
import AlamofireImage

class RestaurantDetailViewController: UIViewController, RepositoryCallback {
    
    @IBOutlet var backgroundImage: UIImageView!
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var descriptionLabel: UILabel!
    @IBOutlet var addressLabel: UILabel!
    @IBOutlet var btnSubOrUnsub: UIButton!
    
    var subscriptions: [Subscription] = []
    var restaurant:Restaurant!
    let subscriptionRepository: SubscriptionsRepository = SubscriptionsRepository()
    var subscribed: Bool = false
    var currentSubscription: Subscription?

    override func viewDidLoad() {
        super.viewDidLoad()
        subscriptionRepository.getMySubscriptions({ subscriptions in
            for subscription in subscriptions {
                if (subscription.restaurant.name == self.restaurant.name) {
                    self.currentSubscription = subscription
                    self.showUnsubscribe()
                    return;
                }
            }
            self.showSubscribe()
        })
        printRestaurant()
    }
    
    override func viewDidAppear(animated: Bool) {
        //self.tabBarController?.tabBar.hidden = true
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func printRestaurant() {
        titleLabel.text = restaurant.name
        addressLabel.text = restaurant.address
        descriptionLabel.text = restaurant.description
        if let
            imageUrl = restaurant.photo,
            url = NSURL(string: imageUrl)
        {
            backgroundImage.af_setImageWithURL(url, filter: AspectScaledToFillSizeFilter(size: CGSize(width: backgroundImage.frame.width, height: backgroundImage.frame.height)))
        }
    }
    
    func addedItem<T>(item: T) {
        let subscription: Subscription = item as! Subscription
        if subscription.restaurant.name == restaurant.name {
            showUnsubscribe()
        }
        
    }
    
    @IBAction func btnSubOrUnsubClicked(sender: UIButton) {
        if subscribed {
            if let subscription = currentSubscription {
                subscriptionRepository.removeItem(subscription)
            }
        } else {
            subscriptionRepository.addSubscription(restaurant)
        }
    }
    
    func removedItem<T>(item: T) {
        let subscription: Subscription = item as! Subscription
        if subscription.restaurant.name == restaurant.name {
            showSubscribe()
        }
    }
    
    func showUnsubscribe() {
        btnSubOrUnsub.hidden = false
        btnSubOrUnsub.setTitle("Unsubscribe", forState: UIControlState.Normal)
        subscribed = true
    }
    
    func showSubscribe() {
        btnSubOrUnsub.setTitle("Subscribe", forState: UIControlState.Normal)
        btnSubOrUnsub.hidden = false
        subscribed = false
    }
}
