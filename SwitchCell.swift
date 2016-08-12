//
//  SwitchCell.swift
//  Yelp
//
//  Created by kate_odnous on 8/9/16.
//  Copyright © 2016 Timothy Lee. All rights reserved.
//

import UIKit

@objc protocol SwitchCellDelegate {
  optional func switchCell(switchCell: SwitchCell, didChangeValue value: Bool)
}

class SwitchCell: UITableViewCell {

  @IBOutlet weak var switchLabel: UILabel!
  @IBOutlet weak var onSwitch: UISwitch!

  weak var delegate: SwitchCellDelegate?
  var filterPreferences: FilterPreferences?
  var filterCategory: FilterCategory? {
    didSet {
      if let filterCategory = filterCategory {
        switchLabel.text = filterCategory.title
        onSwitch.on = filterPreferences?.isFilterCategoryOn(filterCategory) ?? false
      }
    }
  }

   override func awakeFromNib() {
    super.awakeFromNib()

    self.layoutMargins = UIEdgeInsetsZero
    self.preservesSuperviewLayoutMargins = false

    onSwitch.addTarget(self, action: #selector(SwitchCell.switchValueChanged) , forControlEvents: UIControlEvents.ValueChanged)
  }

  override func setSelected(selected: Bool, animated: Bool) {
    super.setSelected(selected, animated: animated)
  }

  func switchValueChanged() {
    delegate?.switchCell?(self, didChangeValue: onSwitch.on)
  }
  
}
