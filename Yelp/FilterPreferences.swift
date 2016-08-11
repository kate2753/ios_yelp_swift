//
//  FilterPreferences.swift
//  Yelp
//
//  Created by kate_odnous on 8/11/16.
//  Copyright © 2016 Timothy Lee. All rights reserved.
//

import UIKit

class FilterPreferences: NSObject {
  var categories: [String] = []

  func updateFilterPreference(filter: Filter, filterCategory: FilterCategory, isOn: Bool) {
    if filter is CategoriesFilter {
      let idxOfCategory = categories.indexOf(filterCategory.name)
      if isOn && idxOfCategory == nil {
          categories.append(filterCategory.name)
      } else if !isOn && idxOfCategory != nil {
        categories.removeAtIndex(idxOfCategory!)
      }
    }
  }

  func isFilterCategoryOn(filter: Filter, filterCategory: FilterCategory) -> Bool {
    if filter is CategoriesFilter {
      return categories.contains(filterCategory.name)
    }

    return false
  }
}
