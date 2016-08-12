//
//  Filter.swift
//  Yelp
//
//  Created by kate_odnous on 8/10/16.
//  Copyright © 2016 Timothy Lee. All rights reserved.
//

import Foundation

class Filter: NSObject {
  let title: String
  var categories: [FilterCategory] = []
  var isCollapsed: Bool = false {
    didSet {
      if !isCollapsible && isCollapsed {
        isCollapsed = false
      }
    }
  }
  var isCollapsible = false

  init(title: String) {
    self.title = title
  }
}
