//
//  DealsFilter.swift
//  Yelp
//
//  Created by kate_odnous on 8/11/16.
//  Copyright © 2016 Timothy Lee. All rights reserved.
//

import UIKit

class DealsFilter: Filter {
  init() {
    var categories = [FilterCategory]()
    categories.append(FilterCategory(title: "Offering a Deal", value: "deal"))
    super.init(name: "Deals", categories: categories)
  }
}
