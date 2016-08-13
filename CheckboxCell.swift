//
//  CheckboxCell.swift
//  Yelp
//
//  Created by kate_odnous on 8/12/16.
//  Copyright © 2016 Timothy Lee. All rights reserved.
//

import UIKit

class CheckboxCell: FiltersTableViewCell {

  @IBOutlet weak var checkboxImageView: UIImageView!

  @IBOutlet weak var filterTitleLabel: UILabel!

  var isCheckboxOn: Bool = false

  override func onFilterCategoryChanged() {
    if let filterCategory = filterCategory {
      filterTitleLabel.text = filterCategory.title
      isCheckboxOn = filterPreferences?.isFilterCategoryOn(filterCategory) ?? false
      checkboxImageView.image = isCheckboxOn ? UIImage(named: "Complete") : UIImage(named: "CircleOutline")
    }
  }

  override func awakeFromNib() {
    super.awakeFromNib()

    let checkboxTap = UITapGestureRecognizer(target: self, action: #selector(CheckboxCell.checkboxTapped))
    checkboxImageView.userInteractionEnabled = true
    checkboxImageView.addGestureRecognizer(checkboxTap)
  }

  func checkboxTapped() {
    isCheckboxOn = !isCheckboxOn
    checkboxImageView.image = isCheckboxOn ? UIImage(named: "Complete") : UIImage(named: "CircleOutline")
    delegate?.filtersTableViewCell?(self, didChangeValue: isCheckboxOn)
  }
}
