//
//  DistanceFilter.swift
//  Yelp
//
//  Created by kate_odnous on 8/11/16.
//  Copyright © 2016 Timothy Lee. All rights reserved.
//

import UIKit

class DistanceFilter: Filter {
  let supportedDistances = [
    "0.3 miles": DistanceFilter.milesToMeters(0.3),
    "1 mile": DistanceFilter.milesToMeters(1),
    "5 miles": DistanceFilter.milesToMeters(5),
    "20 miles": DistanceFilter.milesToMeters(20)
  ]

  init() {
    super.init(title: "Distance")

    var categories = [FilterCategory]()
    categories.append(FilterCategory(title: "Auto", value: "", filter: self))
    supportedDistances.forEach() { title, distance in
      categories.append(FilterCategory(title: title, value: "\(distance)", filter: self))
    }

    self.categories = categories
    self.isCollapsible = true
    self.isCollapsed = true
    self.reusableCellIdentifier = "CheckboxCell"
  }

  private class func milesToMeters(miles: Double) -> Double {
    return miles/0.00062137
  }
}
