//
//  SortFilter.swift
//  Yelp
//
//  Created by kate_odnous on 8/11/16.
//  Copyright © 2016 Timothy Lee. All rights reserved.
//

import UIKit

class SortFilter: Filter {
  init() {
    var categories = [FilterCategory]()

    categories.append(FilterCategory(title: "Best Match", value: "\(YelpSortMode.BestMatched.rawValue)"))
    categories.append(FilterCategory(title: "Distance", value: "\(YelpSortMode.Distance.rawValue)"))
    categories.append(FilterCategory(title: "Highest Rated", value: "\(YelpSortMode.HighestRated.rawValue)"))

    super.init(name: "Sort By", categories: categories)
  }
}
