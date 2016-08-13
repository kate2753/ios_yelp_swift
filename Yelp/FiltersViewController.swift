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
    if let filtersTableViewCell = sender.view as? FiltersTableViewCell {
      filtersTableViewCell.filter?.isCollapsed = false
      tableView.reloadSections( NSIndexSet(index: filtersTableViewCell.sectionIndex!), withRowAnimation: UITableViewRowAnimation.Automatic)
    }
  }

  func didTapSeeAllSection(sender: UITapGestureRecognizer) {
    if let seeAllCell = sender.view as? SeeAllCell {
      seeAllCell.filter?.areAllCategoriesVisible = true
      tableView.reloadSections( NSIndexSet(index: seeAllCell.sectionIndex!), withRowAnimation: UITableViewRowAnimation.Automatic)
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
    if filter.areAllCategoriesVisible {
      return filter.isCollapsed ? 1 : filter.categories.count
    } else {
      // number of categories we want to show + 1 cell for "see all" cell
      return filter.numCategoriesVisibleByDefault + 1
    }
  }

  func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
    let filter = filters[indexPath.section]


    if !filter.areAllCategoriesVisible && indexPath.row == filter.numCategoriesVisibleByDefault {
      let cell = tableView.dequeueReusableCellWithIdentifier("SeeAllCell") as! SeeAllCell
      cell.filter = filter
      cell.sectionIndex = indexPath.section

      let seeAllSectionTap = UITapGestureRecognizer(target: self, action: #selector(FiltersViewController.didTapSeeAllSection))
      cell.addGestureRecognizer(seeAllSectionTap)

      return cell
    }

    if filter.isCollapsible && filter.isCollapsed {
      let cell = tableView.dequeueReusableCellWithIdentifier("CollapsedFilterCell") as! CollapsedFilterCell
      cell.filterPreferences = filterPreferences
      cell.filter = filter
      cell.sectionIndex = indexPath.section

      let collapsedSectionTap = UITapGestureRecognizer(target: self, action: #selector(FiltersViewController.didTapCollapsedSection))
      cell.addGestureRecognizer(collapsedSectionTap)

      return cell
    } else {
      let cell = tableView.dequeueReusableCellWithIdentifier(filter.reusableCellIdentifier) as! FiltersTableViewCell
      cell.filterPreferences = filterPreferences
      cell.filterCategory = filter.categories[indexPath.row]
      cell.sectionIndex = indexPath.section
      cell.delegate = self

      return cell
    }
  }
}


extension FiltersViewController: FiltersTableViewCellDelegate {
  func filtersTableViewCell(filtersTableViewCell: FiltersTableViewCell, didChangeValue value: Bool) {
    filterPreferences.updateFilterPreference(filtersTableViewCell.filterCategory!, isOn: value)
    let filter = filtersTableViewCell.filterCategory!.filter
    if filter.isCollapsible {
      filter.isCollapsed = true
      tableView.reloadSections( NSIndexSet(index: filtersTableViewCell.sectionIndex!), withRowAnimation: UITableViewRowAnimation.Automatic)
    } else {
      tableView.reloadData()
    }
  }
}