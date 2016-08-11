//
//  BusinessCell.swift
//  Yelp
//
//  Created by kate_odnous on 8/9/16.
//  Copyright © 2016 Timothy Lee. All rights reserved.
//

import UIKit

class BusinessCell: UITableViewCell {

  @IBOutlet weak var thumbImageView: UIImageView!
  @IBOutlet weak var nameLabel: UILabel!
  @IBOutlet weak var distanceLabel: UILabel!
  @IBOutlet weak var ratingImageView: UIImageView!
  @IBOutlet weak var reviewsLabel: UILabel!
  @IBOutlet weak var addressLabel: UILabel!
  @IBOutlet weak var categoriesLabel: UILabel!

  var business: Business! {
    didSet {
      if let imageUrl = business.imageURL {
        thumbImageView.setImageWithURL(imageUrl)
      }
      nameLabel.text = business.name
      distanceLabel.text = business.distance
      ratingImageView.setImageWithURL(business.ratingImageURL!)
      reviewsLabel.text = "\(business.reviewCount!) Reviews"
      addressLabel.text = business.address
      categoriesLabel.text = business.categories
    }
  }

  override func awakeFromNib() {
    super.awakeFromNib()
    thumbImageView.layer.cornerRadius = 5

    self.layoutMargins = UIEdgeInsetsZero
    self.preservesSuperviewLayoutMargins = false
  }

  override func setSelected(selected: Bool, animated: Bool) {
    super.setSelected(selected, animated: animated)

    // Configure the view for the selected state
  }
  
}
