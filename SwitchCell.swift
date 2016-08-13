//
//  SwitchCell.swift
//  Yelp
//
//  Created by kate_odnous on 8/9/16.
//  Copyright © 2016 Timothy Lee. All rights reserved.
//

import UIKit

class SwitchCell: FiltersTableViewCell {

  @IBOutlet weak var switchLabel: UILabel!
  @IBOutlet weak var onSwitch: UISwitch!

  override func onFilterCategoryChanged(){
    super.onFilterCategoryChanged()
    if let filterCategory = filterCategory {
      switchLabel.text = filterCategory.title
      onSwitch.on = filterPreferences?.isFilterCategoryOn(filterCategory) ?? false
    }
  }

  override func awakeFromNib() {
    super.awakeFromNib()

    onSwitch.addTarget(self, action: #selector(SwitchCell.switchValueChanged) , forControlEvents: UIControlEvents.ValueChanged)
  }

  override func setSelected(selected: Bool, animated: Bool) {
    super.setSelected(selected, animated: animated)
  }

  func switchValueChanged() {
    delegate?.filtersTableViewCell?(self, didChangeValue: onSwitch.on)
  }
  
}
