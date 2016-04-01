//
//  Repository.swift
//  gourmet
//
//  Created by Alejandro Miragall Arnal on 31/3/16.
//  Copyright © 2016 Alejandro Miragall Arnal. All rights reserved.
//

import Foundation
import Firebase

public protocol RepositoryCallback {
    func addedItem<T>(item: T)
    func removedItem<T>(item: T)
}

public class Repository<T> {
    var callback: RepositoryCallback?
    
    public func register(callback: RepositoryCallback) {
        self.callback = callback;
        initListener({$0})
    }
    
    func register(callback: RepositoryCallback, preprocess: (Firebase -> FQuery)) {
        self.callback = callback;
        initListener(preprocess)
    }
    
    public func getItems(callback: [T] -> Void) {
        return getItems(callback, preprocess: { $0 })
    }
    
    func getItems(callback: [T] -> Void, preprocess: (Firebase -> FQuery)) {
        let firebase = getConnection()
        preprocess(firebase).observeEventType(.Value,
            withBlock: { snapshot in
                var items = [T]()
                for child in (snapshot.children.allObjects as? [FDataSnapshot])! {
                    let item: T = self.map(child)!
                    items.append(item)
                }
                callback(items)
        })
    }
    
    public func addItem(item: T) {
        let firebase = getConnection()
        firebase.childByAutoId().setValue(item as! AnyObject)
    }
    
    func initListener(let preprocess: (Firebase -> FQuery)) {
        let firebase = getConnection()
        preprocess(firebase).observeEventType(.ChildAdded,
            withBlock: { snapshot in
                let item: T = self.map(snapshot)!
                self.callback!.addedItem(item)
        })
        
        preprocess(firebase).observeEventType(.ChildRemoved,
            withBlock: { snapshot in
                let item: T = self.map(snapshot)!
                self.callback!.removedItem(item)
        })
    }
    
    func getConnection() -> Firebase {
        return Firebase(url: getUrl())
    }
    
    func getUrl() -> String {
        return "https://tuenti-restaurants.firebaseio.com/events"
    }
    
    func map(let snapshot: FDataSnapshot) -> T? {
        return nil
    }
    
}
