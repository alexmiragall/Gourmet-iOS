//
//  RestaurantDetailViewController.swift
//  gourmet
//
//  Created by Alejandro Miragall Arnal on 15/3/16.
//  Copyright © 2016 Alejandro Miragall Arnal. All rights reserved.
//

import UIKit
import AlamofireImage

class RestaurantDetailViewController: UIViewController {
    
    @IBOutlet var backgroundImage: UIImageView!
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var descriptionLabel: UILabel!
    @IBOutlet var addressLabel: UILabel!
    
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

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
