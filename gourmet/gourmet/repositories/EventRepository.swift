//
//  EventRepository.swift
//  gourmet
//
//  Created by Alejandro Miragall Arnal on 24/3/16.
//  Copyright © 2016 Alejandro Miragall Arnal. All rights reserved.
//
import Foundation
import Firebase

public class EventRepository: Repository<Event> {
    let eventMapper: EventMapper
    
    override init() {
        eventMapper = EventMapper()
    }
    
    override func getUrl() -> String {
        return "https://tuenti-restaurants.firebaseio.com/events"
    }
    
    override func map(snapshot: FDataSnapshot) -> Event {
        return eventMapper.map(snapshot)
    }
}
