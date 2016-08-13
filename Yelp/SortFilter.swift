//
//  SortFilter.swift
//  Yelp
//
//  Created by kate_odnous on 8/11/16.
//  Copyright © 2016 Timothy Lee. All rights reserved.
//

import UIKit

class SortFilter: Filter {
  let sortCategories = [
    "Best Match": YelpSortMode.BestMatched.rawValue,
    "Distance":YelpSortMode.Distance.rawValue,
    "Highest Rated":YelpSortMode.HighestRated.rawValue
  ]

  init() {
    super.init(title: "Sort By")

    var categories = [FilterCategory]()
    sortCategories.forEach(){ title, value in
      categories.append(FilterCategory(title: title, value: "\(value)", filter: self))
    }

    self.categories = categories
    self.isCollapsible = true
    self.isCollapsed = true
    self.reusableCellIdentifier = "CheckboxCell"
  }
}
