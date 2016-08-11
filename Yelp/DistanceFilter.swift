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
    var categories = [FilterCategory]()
    categories.append(FilterCategory(title: "Auto", value: ""))
    supportedDistances.forEach() { title, distance in
      categories.append(FilterCategory(title: title, value: "\(distance)"))
    }

    super.init(name: "Distance", categories: categories)
  }

  private class func milesToMeters(miles: Double) -> Double {
    return miles/0.00062137
  }
}
