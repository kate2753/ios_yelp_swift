//
//  CategoriesFilter.swift
//  Yelp
//
//  Created by kate_odnous on 8/10/16.
//  Copyright © 2016 Timothy Lee. All rights reserved.
//

import UIKit

class CategoriesFilter: Filter {
  init() {
    super.init(title: "Categories")
    var categories = [FilterCategory]()

    if let path = NSBundle.mainBundle().pathForResource("categories", ofType: "json") {
      if let data = NSData(contentsOfFile: path) {
        do {
          let object = try NSJSONSerialization.JSONObjectWithData(data, options: .AllowFragments)
          if let dictionary = object as? [[String: AnyObject]] {
            dictionary.forEach() { category in
              let title = category["title"] as! String
              let name = category["alias"] as! String
              let filterCategory = FilterCategory(title: title, value: name, filter: self)
              categories.append(filterCategory)
            }
          }
        } catch {
        }
      }
    }

    self.categories = categories
    self.areAllCategoriesVisible = false
  }
}