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
  var filter: Filter?
  var filterCategory: FilterCategory? {
    didSet {
      switchLabel.text = filterCategory?.title
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
    delegate?.switchCell?(self, didChangeValue: onSwitch.on)
  }
  
}
