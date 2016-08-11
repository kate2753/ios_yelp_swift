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
  var sort: YelpSortMode?
  var deals: Bool = false
  var distance: Double?

  func updateFilterPreference(filter: Filter, filterCategory: FilterCategory, isOn: Bool) {
    if filter is CategoriesFilter {
      let idxOfCategory = categories.indexOf(filterCategory.value)
      if isOn && idxOfCategory == nil {
        categories.append(filterCategory.value)
      } else if !isOn && idxOfCategory != nil {
        categories.removeAtIndex(idxOfCategory!)
      }
    } else if filter is SortFilter {
      if isOn {
        if let sortMode = YelpSortMode(rawValue: Int(filterCategory.value)!) {
          sort = sortMode
        }
      } else {
        sort = nil
      }
    } else if filter is DealsFilter {
      deals = isOn
    } else if filter is DistanceFilter {
      if let distance = Double(filterCategory.value) {
        self.distance = distance
      } else {
        self.distance = nil
      }
    }
  }

  func isFilterCategoryOn(filter: Filter, filterCategory: FilterCategory) -> Bool {
    if filter is CategoriesFilter {
      return categories.contains(filterCategory.value)
    } else if filter is SortFilter {
      if sort == nil {
        return false
      } else {
        return filterCategory.value == "\(sort!.rawValue)"
      }
    } else if filter is DealsFilter {
      return deals
    } else if filter is DistanceFilter {
      if let distance = Double(filterCategory.value) {
        return self.distance == distance
      } else {
        // Auto filter
        return self.distance == nil
      }
    }

    return false
  }
}
