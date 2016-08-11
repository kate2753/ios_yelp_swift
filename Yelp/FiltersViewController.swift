//
//  FiltersViewController.swift
//  Yelp
//
//  Created by kate_odnous on 8/9/16.
//  Copyright © 2016 Timothy Lee. All rights reserved.
//

import UIKit

@objc protocol FiltersViewControllerDelegate {
  optional func filtersViewController(filtersViewController:FiltersViewController, didUpdateFilters:FilterPreferences)
}

class FiltersViewController: UIViewController {

  @IBOutlet weak var tableView: UITableView!
  weak var delegate: FiltersViewControllerDelegate?

  var filters = [
    DealsFilter(),
    DistanceFilter(),
    SortFilter(),
    CategoriesFilter()
  ]

  var filterPreferences = FilterPreferences()

  override func viewDidLoad() {
    super.viewDidLoad()
    tableView.delegate = self
    tableView.dataSource = self
    tableView.rowHeight = UITableViewAutomaticDimension
    tableView.estimatedRowHeight = 200
    tableView.separatorInset = UIEdgeInsetsZero
  }

  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }

  @IBAction func onCancelButton(sender: AnyObject) {
    dismissViewControllerAnimated(true, completion:nil)
  }

  @IBAction func onSearchButton(sender: AnyObject) {
    delegate?.filtersViewController?(self, didUpdateFilters: filterPreferences)
    dismissViewControllerAnimated(true, completion:nil)
  }
}

extension FiltersViewController: UITableViewDelegate, UITableViewDataSource {
  func numberOfSectionsInTableView(tableView: UITableView) -> Int {
    return filters.count
  }

  func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
    return filters[section].name
  }

  func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return filters[section].categories.count
  }

  func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCellWithIdentifier("SwitchCell") as! SwitchCell
    let filter = filters[indexPath.section]
    let filterCategory = filter.categories[indexPath.row]
    cell.filter = filter
    cell.filterCategory = filterCategory
    cell.onSwitch.on = filterPreferences.isFilterCategoryOn(filter, filterCategory: filterCategory)
    cell.delegate = self
    return cell
  }
}


extension FiltersViewController: SwitchCellDelegate {
  func switchCell(switchCell: SwitchCell, didChangeValue value: Bool) {
    filterPreferences.updateFilterPreference(switchCell.filter!, filterCategory: switchCell.filterCategory!, isOn: value)
    tableView.reloadData()
  }
}