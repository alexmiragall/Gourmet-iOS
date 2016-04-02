//
//  SubscriptionsRepository.swift
//  gourmet
//
//  Created by Alejandro Miragall Arnal on 31/3/16.
//  Copyright © 2016 Alejandro Miragall Arnal. All rights reserved.
//

import Foundation
import Firebase

public class SubscriptionsRepository: Repository<Subscription> {
    let TEST_USER_NAME: String = "testUserID"
    
    let subscriptionMapper: SubscriptionMapper
    
    override init() {
        subscriptionMapper = SubscriptionMapper()
        
        super.init()
    }
    
    override func getUrl() -> String {
        return "https://tuenti-restaurants.firebaseio.com/subscriptions"
    }
    
    override func map(snapshot: FDataSnapshot) -> Subscription {
        return subscriptionMapper.map(snapshot)
    }
    
    public func getMySubscriptions(callback: [Subscription] -> Void) {
        self.getItems(callback, preprocess: {firebase -> FQuery in
            return firebase.queryStartingAtValue(self.TEST_USER_NAME).queryEndingAtValue(self.TEST_USER_NAME)
        })
    }
    
    public func addSubscription(restaurant: Restaurant) {
        if let user = UserManager.instance.getUser() {
            let item: Subscription = Subscription(restaurant: restaurant, user: user)
            let firebase = getConnection()
            firebase.childByAutoId().setValue(subscriptionMapper.mapInverse(item) as! AnyObject, andPriority: self.TEST_USER_NAME)
        }
    }
    
    public func removeItem(item: Subscription) {
        let firebase = getConnection()
        firebase.childByAppendingPath(item.id!).removeValue()
    }
    
    public func registerMySubscriptions(callback: RepositoryCallback) {
        self.register(callback, preprocess: {firebase -> FQuery in
            return firebase.queryStartingAtValue(self.TEST_USER_NAME).queryEndingAtValue(self.TEST_USER_NAME)
        })
    }
}