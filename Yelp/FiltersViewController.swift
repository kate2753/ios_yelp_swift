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

  func didTapCollapsedSection(sender: UITapGestureRecognizer) {
    if let collapsedFilterCell = sender.view as? CollapsedFilterCell {
      collapsedFilterCell.filter?.isCollapsed = false
      tableView.reloadSections( NSIndexSet(index: collapsedFilterCell.sectionIndex!), withRowAnimation: UITableViewRowAnimation.Automatic)
    }
  }
}

extension FiltersViewController: UITableViewDelegate, UITableViewDataSource {
  func numberOfSectionsInTableView(tableView: UITableView) -> Int {
    return filters.count
  }

  func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
    return filters[section].title
  }

  func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    let filter = filters[section]
    return filter.isCollapsed ? 1 : filter.categories.count
  }

  func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
    let filter = filters[indexPath.section]

    if filter.isCollapsible && filter.isCollapsed {
      let cell = tableView.dequeueReusableCellWithIdentifier("CollapsedFilterCell") as! CollapsedFilterCell
      cell.filterPreferences = filterPreferences
      cell.filter = filter
      cell.sectionIndex = indexPath.section

      let collapsedSectionTap = UITapGestureRecognizer(target: self, action: #selector(FiltersViewController.didTapCollapsedSection))
      cell.addGestureRecognizer(collapsedSectionTap)

      return cell
    } else {
      let cell = tableView.dequeueReusableCellWithIdentifier("SwitchCell") as! SwitchCell
      cell.filterPreferences = filterPreferences
      cell.filterCategory = filter.categories[indexPath.row]
      cell.delegate = self
      cell.sectionIndex = indexPath.section
      return cell
    }
  }
}


extension FiltersViewController: SwitchCellDelegate {
  func switchCell(switchCell: SwitchCell, didChangeValue value: Bool) {
    filterPreferences.updateFilterPreference(switchCell.filterCategory!, isOn: value)
    let filter = switchCell.filterCategory!.filter
    if filter.isCollapsible {
      filter.isCollapsed = true
    }
    tableView.reloadSections( NSIndexSet(index: switchCell.sectionIndex!), withRowAnimation: UITableViewRowAnimation.Automatic)
  }
}