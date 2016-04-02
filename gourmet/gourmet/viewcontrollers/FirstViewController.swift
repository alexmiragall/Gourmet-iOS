//
//  FirstViewController.swift
//  gourmet
//
//  Created by Alejandro Miragall Arnal on 15/3/16.
//  Copyright © 2016 Alejandro Miragall Arnal. All rights reserved.
//

import UIKit
import MapKit
import Firebase
import AlamofireImage

class FirstViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, MKMapViewDelegate, CLLocationManagerDelegate, GIDSignInUIDelegate
{
    
    @IBOutlet
    var mapView: MKMapView!
    
    @IBOutlet
    var tableView: UITableView!
    
    let locationManager = CLLocationManager()
    
    var restaurantRepository: RestaurantsRepository!
    
    var items: [Restaurant] = []
    
    var userManager = UserManager.instance
    
    @IBAction func viewChanged(sender: UISegmentedControl) {
        if sender.selectedSegmentIndex == 0 {
            tableView.hidden = true
            mapView.hidden = false
        } else {
            tableView.hidden = false
            mapView.hidden = true
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        userManager.signIn(self, callback: { (error, errorType) in
            if (error) {
                print("Error login: \(errorType)")
            } else {
                print("Success login")
            }
        })
        restaurantRepository = RestaurantsRepository()
        let nib = UINib(nibName: "RestaurantTableViewCell", bundle: nil)
        tableView.registerNib(nib, forCellReuseIdentifier: RestaurantTableViewCell.name)
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        mapView.delegate = self
        getRestaurants()
       
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "segueToRestaurantDetail" {
            let viewController = segue.destinationViewController as! RestaurantDetailViewController
            viewController.hidesBottomBarWhenPushed = true
            viewController.restaurant = sender as? Restaurant
        }
    }
    
    func locationManager(manager: CLLocationManager!, didChangeAuthorizationStatus status: CLAuthorizationStatus) {
        switch status {
        case .Authorized, .AuthorizedWhenInUse:
            manager.startUpdatingLocation()
            self.mapView.showsUserLocation = true
        default: break
        }
    }
    
    func mapView(mapView: MKMapView, didUpdateUserLocation userLocation: MKUserLocation) {
        let region = MKCoordinateRegionMakeWithDistance (
            userLocation.location!.coordinate, 10000, 10000)
        mapView.setRegion(region, animated: true)
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
        restaurantRepository.getItems({
            self.items.appendContentsOf($0)
            dispatch_async(dispatch_get_main_queue(), {
                self.tableView.reloadData()
                self.updateMap()
            })
        })
    }
    
    func updateMap() {
        for rest in items {
            mapView.addAnnotation(RestaurantItem(title: rest.name, coordinate: CLLocationCoordinate2D(latitude: rest.lat!, longitude: rest.lon!), info: rest.description))
        }
    }
}

