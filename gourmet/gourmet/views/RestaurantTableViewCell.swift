//
//  RestaurantTableCell.swift
//  gourmet
//
//  Created by Alejandro Miragall Arnal on 21/3/16.
//  Copyright © 2016 Alejandro Miragall Arnal. All rights reserved.
//

import UIKit
import AlamofireImage

class RestaurantTableViewCell : UITableViewCell {
    static let name = "RestaurantTableViewCell"
    @IBOutlet var backgroundImage: UIImageView!
    @IBOutlet var titleLabel: UILabel!
    
    func loadItem(title title: String?, image: String?, completion: (Void -> Void)) {
        if let
            imageUrl = image,
            url = NSURL(string: imageUrl) {
                self.backgroundImage.af_setImageWithURL(url, filter: AspectScaledToFillSizeCircleFilter(size: CGSize(width: 100.0, height: 100.0)), completion: {
                    _ in
                    completion();
                })
        }
        titleLabel.text = title
    }
}