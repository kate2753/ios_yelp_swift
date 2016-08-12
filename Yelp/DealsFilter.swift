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
    super.init(title: "Deals")

    var categories = [FilterCategory]()
    categories.append(FilterCategory(title: "Offering a Deal", value: "deal", filter: self))

    self.categories = categories
  }
}
