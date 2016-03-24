//
//  EventRepository.swift
//  gourmet
//
//  Created by Alejandro Miragall Arnal on 24/3/16.
//  Copyright © 2016 Alejandro Miragall Arnal. All rights reserved.
//
import Foundation
import Firebase

class EventRepository {
    let eventMapper: EventMapper
    
    init() {
        eventMapper = EventMapper()
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
}
