//
//  SecondViewController.swift
//  gourmet
//
//  Created by Alejandro Miragall Arnal on 15/3/16.
//  Copyright © 2016 Alejandro Miragall Arnal. All rights reserved.
//

import UIKit

class EventTabViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, EventRepositoryListener {

    @IBOutlet
    var tableView: UITableView!
    
    var eventRepository: EventRepository!
    
    var events: [Event] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        eventRepository = EventRepository(listener: self)
        let nib = UINib(nibName: "EventTableViewCell", bundle: nil)
        //tableView.rowHeight = UITableViewAutomaticDimension
        //tableView.estimatedRowHeight = 250.0
        tableView.registerNib(nib, forCellReuseIdentifier: EventTableViewCell.name)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.events.count;
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell:EventTableViewCell = self.tableView.dequeueReusableCellWithIdentifier(EventTableViewCell.name) as! EventTableViewCell
        let event: Event = self.events[indexPath.row]
        let date = NSDate(timeIntervalSince1970: NSNumber(integer: event.date).doubleValue / 1000)
        cell.loadItem(title: event.restaurant.name!,subtitle: String(format: "Created by %@ at %@", event.owner.name, date), description: event.comment, image: event.restaurant.photo, completion: { cell.setNeedsLayout() })
        return cell
    }   
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        //performSegueWithIdentifier("segueToRestaurantDetail", sender: self.events[indexPath.row])
        print("You selected cell #\(indexPath.row)!")
    }
    
    func addedEvent(event: Event) {
        self.events.append(event)
        self.tableView.reloadData()
    }
    
    func removedEvent(event: Event) {
        if let index = self.events.indexOf(event) {
            self.events.removeAtIndex(index)
            self.tableView.reloadData()
        }
    }
}

