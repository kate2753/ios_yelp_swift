//
//  CollapsedFilterCell.swift
//  Yelp
//
//  Created by kate_odnous on 8/11/16.
//  Copyright © 2016 Timothy Lee. All rights reserved.
//

import UIKit

class CollapsedFilterCell: FiltersTableViewCell {

  @IBOutlet weak var selectedFilterTitle: UILabel!

  override func onFilterChanged() {
    if let filter = filter {
      selectedFilterTitle.text = filterPreferences?.getSelectedCategoryTitle(filter)
    }
  }

  override func awakeFromNib() {
    super.awakeFromNib()
  }

  override func setSelected(selected: Bool, animated: Bool) {
    super.setSelected(selected, animated: animated)
  }
}
