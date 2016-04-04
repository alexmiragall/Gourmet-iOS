//
//  CreateRestaurantViewController.swift
//  gourmet
//
//  Created by Alejandro Miragall Arnal on 2/4/16.
//  Copyright © 2016 Alejandro Miragall Arnal. All rights reserved.
//

import Foundation
import AlamofireImage

class CreateRestaurantViewController: UIViewController, UIPopoverPresentationControllerDelegate,
    UIAlertViewDelegate {
    
    @IBOutlet var image: UIImageView!
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var descriptionTextView: UITextView!
    @IBOutlet var authorLabel: UILabel!
    @IBOutlet var dateLabel: UILabel!
    
    var alertView: UIAlertView?;
    var eventDate = NSDate()
    
    let eventRepository = EventRepository()
    var restaurant:Restaurant!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        printRestaurant()
    }
    
    override func viewDidAppear(animated: Bool) {
        //self.tabBarController?.tabBar.hidden = true
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func doneButtonClicked(sender: UIBarButtonItem) {
        let event = Event(restaurant: restaurant, date: eventDate.timeIntervalSince1970, owner: UserManager.instance.getUser()!, comment: descriptionTextView.text, occupants: nil)
        eventRepository.addEvent(event)
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    @IBAction func changeDateClicked(sender: UIButton) {
        let viewController: UIViewController = UIViewController()
        let view: UIView = UIView(frame: CGRectMake(0, 0, 300, 100))
        
        let datepicker: UIDatePicker = UIDatePicker(frame: CGRectMake(0, 0, 300, 100))
        datepicker.datePickerMode = UIDatePickerMode.DateAndTime;
        datepicker.hidden = false;
        datepicker.date = eventDate;
        datepicker.addTarget(self, action: Selector("labelChange:"), forControlEvents: UIControlEvents.ValueChanged)
        view.addSubview(datepicker)
        viewController.view.addSubview(view)
        viewController.modalPresentationStyle = .Popover
        viewController.preferredContentSize = CGSizeMake(300, 100)
        
        let popoverMenuViewController = viewController.popoverPresentationController
        popoverMenuViewController?.permittedArrowDirections = .Any
        popoverMenuViewController?.delegate = self
        popoverMenuViewController?.sourceView = sender
        popoverMenuViewController?.sourceRect = sender.bounds
        presentViewController(
            viewController,
            animated: true,
            completion: nil)
    }
    
    @IBAction func labelChange(sender: AnyObject)
    {
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateStyle = .ShortStyle
        dateFormatter.timeStyle = .ShortStyle
        dateFormatter.doesRelativeDateFormatting = true
        let uploadDate = dateFormatter.stringFromDate((sender as! UIDatePicker).date)
        dateLabel.text = "on \(uploadDate)"
        eventDate = (sender as! UIDatePicker).date
    }
    
    func adaptivePresentationStyleForPresentationController(
        controller: UIPresentationController!) -> UIModalPresentationStyle {
            return .None
    }
    
    func printRestaurant() {
        titleLabel.text = restaurant.name
        authorLabel.text = "Created by \(UserManager.instance.getUser()!.name)"
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateStyle = .ShortStyle
        dateFormatter.timeStyle = .ShortStyle
        dateFormatter.doesRelativeDateFormatting = true
        let uploadDate = dateFormatter.stringFromDate(eventDate)
        dateLabel.text = "on \(uploadDate)"
        
        if let
            imageUrl = restaurant.photo,
            url = NSURL(string: imageUrl)
        {
            image.af_setImageWithURL(url, filter: AspectScaledToFillSizeFilter(size: CGSize(width: image.frame.width, height: image.frame.height)))
        }
    }
    
    func showLoading() {
        alertView = UIAlertView(title: "Creating event", message: nil, delegate: self, cancelButtonTitle: nil)
        alertView!.show()
        let indicator = UIActivityIndicatorView(activityIndicatorStyle: UIActivityIndicatorViewStyle.WhiteLarge)
        
        // Adjust the indicator so it is up a few pixels from the bottom of the alert
        indicator.center = CGPointMake(alertView!.bounds.size.width / 2, alertView!.bounds.size.height - 50);
        indicator.startAnimating()
        alertView!.addSubview(indicator)
    }
    
    func hideLoading() {
        if let alertView = self.alertView {
            alertView.dismissWithClickedButtonIndex(0, animated: true)
            self.alertView = nil
        }
    }
}
