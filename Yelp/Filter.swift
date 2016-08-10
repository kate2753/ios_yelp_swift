//
//  Filter.swift
//  Yelp
//
//  Created by kate_odnous on 8/10/16.
//  Copyright © 2016 Timothy Lee. All rights reserved.
//

import Foundation

class Filter: NSObject {
  let name: String
  let categories: [FilterCategory]

  init(name: String, categories: [FilterCategory]) {
    self.name = name
    self.categories = categories
  }
}
