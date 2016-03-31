//
//  EventRepository.swift
//  gourmet
//
//  Created by Alejandro Miragall Arnal on 24/3/16.
//  Copyright © 2016 Alejandro Miragall Arnal. All rights reserved.
//
import Foundation
import Firebase

public protocol EventRepositoryListener {
    func addedEvent(event: Event)
    func removedEvent(event: Event)
}

public class EventRepository {
    let eventMapper: EventMapper
    var listener: EventRepositoryListener
    
    init(listener: EventRepositoryListener) {
        eventMapper = EventMapper()
        self.listener = listener
        
        initListener()
    }
    
    func getEvents(callback: [Event] -> Void) {
        let firebase = Firebase(url: "https://tuenti-restaurants.firebaseio.com/events")
        NSLog("Opening Events")
        firebase.observeEventType(.Value,
            withBlock: { snapshot in
                var events = [Event]()
                for child in (snapshot.children.allObjects as? [FDataSnapshot])! {
                    let event = self.eventMapper.map(child)
                    events.append(event)
                }
                
                callback(events)
        })
    }
    
    func initListener() {
        let firebase = Firebase(url: "https://tuenti-restaurants.firebaseio.com/events")
        firebase.observeEventType( .ChildAdded,
            withBlock: { snapshot in
                let event = self.eventMapper.map(snapshot)
                self.listener.addedEvent(event)
        })
        
        firebase.observeEventType( .ChildRemoved,
            withBlock: { snapshot in
                let event = self.eventMapper.map(snapshot)
                self.listener.removedEvent(event)
        })
    }
}
