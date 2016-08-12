//
//  CollapsedFilterCell.swift
//  Yelp
//
//  Created by kate_odnous on 8/11/16.
//  Copyright © 2016 Timothy Lee. All rights reserved.
//

import UIKit

class CollapsedFilterCell: UITableViewCell {

  @IBOutlet weak var selectedFilterTitle: UILabel!

  var filterPreferences: FilterPreferences?
  var sectionIndex: Int?

  weak var filter: Filter? {
    didSet {
      if let filter = filter {
        selectedFilterTitle.text = filterPreferences?.getSelectedCategoryTitle(filter)
      }
    }
  }

  override func awakeFromNib() {
    super.awakeFromNib()
  }

  override func setSelected(selected: Bool, animated: Bool) {
    super.setSelected(selected, animated: animated)
  }
}
