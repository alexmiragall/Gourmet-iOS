//
//  EventTableView.swift
//  gourmet
//
//  Created by Alejandro Miragall Arnal on 30/3/16.
//  Copyright © 2016 Alejandro Miragall Arnal. All rights reserved.
//

import Foundation
import AlamofireImage

class EventTableViewCell : UITableViewCell {
    static let name = "EventTableViewCell"
    @IBOutlet var mainImage: UIImageView!
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var subtitleLabel: UILabel!
    @IBOutlet var descLabel: UILabel!
    
    func loadItem(title title: String,
        subtitle: String,
        description: String?,
        image: String?,
        completion: (Void -> Void))
    {
        if let
            imageUrl = image,
            url = NSURL(string: imageUrl) {
                self.mainImage.af_setImageWithURL(url, filter: AspectScaledToFillSizeCircleFilter(size: CGSize(width: 100.0, height: 100.0)), completion: {
                    _ in
                    completion();
                })
        }
        titleLabel.text = title
        subtitleLabel.text = subtitle
        descLabel.text = description
    }
}