//
//  FilterCategory.swift
//  Yelp
//
//  Created by kate_odnous on 8/10/16.
//  Copyright © 2016 Timothy Lee. All rights reserved.
//

import Foundation

class FilterCategory: NSObject {
  let title: String
  let value: String

  init(title: String, value :String){
    self.title = title
    self.value = value
  }
}