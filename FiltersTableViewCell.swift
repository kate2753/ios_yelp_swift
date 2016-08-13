//
//  FiltersTableViewCell.swift
//  Yelp
//
//  Created by kate_odnous on 8/12/16.
//  Copyright © 2016 Timothy Lee. All rights reserved.
//

import UIKit

@objc protocol FiltersTableViewCellDelegate {
  optional func filtersTableViewCell(filtersTableViewCell: FiltersTableViewCell, didChangeValue value: Bool)
}

class FiltersTableViewCell: UITableViewCell {
  weak var delegate: FiltersTableViewCellDelegate?

  var sectionIndex: Int?
  var filterPreferences: FilterPreferences?
  var filter: Filter? {
    didSet {
      onFilterChanged()
    }
  }
  var filterCategory: FilterCategory? {
    didSet {
      onFilterCategoryChanged()
    }
  }

  func onFilterChanged() -> Void {
    // inherited classes will implement this
  }

  func onFilterCategoryChanged() -> Void {
    // inherited classes will implement this
  }
}
