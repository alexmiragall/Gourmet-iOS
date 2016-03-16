//
//  FirstViewController.swift
//  gourmet
//
//  Created by Alejandro Miragall Arnal on 15/3/16.
//  Copyright © 2016 Alejandro Miragall Arnal. All rights reserved.
//

import UIKit
import Firebase

class CustomTableViewCell : UITableViewCell {
    @IBOutlet var backgroundImage: UIImageView!
    @IBOutlet var titleLabel: UILabel!
    
    func loadItem(title title: String?, image: String?) {
        let url = NSURL(string: image!)
        let data = NSData(contentsOfURL: url!) //make sure your image in this url does exist, otherwise unwrap in a if let check
        if ((data) != nil) {
            backgroundImage.image = UIImage(data: data!)
        }
        titleLabel.text = title
    }
}

class FirstViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    
    @IBOutlet
    var tableView: UITableView!
    
    var items: [Restaurant] = [Restaurant]()

    override func viewDidLoad() {
        super.viewDidLoad()
        let nib = UINib(nibName: "CustomTableViewCell", bundle: nil)
        tableView.registerNib(nib, forCellReuseIdentifier: "customCell")
        loadRestaurant()
       
    }
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        segue.destinationViewController.hidesBottomBarWhenPushed = true
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
        var cell:CustomTableViewCell = self.tableView.dequeueReusableCellWithIdentifier("customCell") as! CustomTableViewCell
        let resto:Restaurant = self.items[indexPath.row]
        cell.loadItem(title: resto.name, image: resto.photo)
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        print("You selected cell #\(indexPath.row)!")
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
                    
                    self.items.appendContentsOf(restaurants)
                }
                
                dispatch_async(dispatch_get_main_queue(), {
                    self.tableView.reloadData()
                })
        })
        
    }
    
    func addEffect() {
        var effect = UIBlurEffect(style: UIBlurEffectStyle.Light)
        
        var effectView = UIVisualEffectView(effect: effect)
        
        effectView.frame = CGRectMake(0, 0, 320, 100)
        
        view.addSubview(effectView)
    }


}

