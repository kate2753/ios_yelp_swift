//
//  BusinessesViewController.swift
//  Yelp
//
//  Created by Timothy Lee on 4/23/15.
//  Copyright (c) 2015 Timothy Lee. All rights reserved.
//

import UIKit

class BusinessesViewController: UIViewController {

  @IBOutlet weak var tableView: UITableView!
  var businesses: [Business]!
  var filterPreferences = FilterPreferences()
  var searchTerm: String = ""

  override func viewDidLoad() {
    super.viewDidLoad()

    tableView.delegate = self
    tableView.dataSource = self
    tableView.rowHeight = UITableViewAutomaticDimension
    tableView.estimatedRowHeight = 120
    tableView.separatorInset = UIEdgeInsetsZero

    let searchBar = UISearchBar()
    searchBar.delegate = self
    searchBar.sizeToFit()
    navigationItem.titleView = searchBar

    updateBusinesses()
  }

  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }

  // MARK: - Navigation

  // In a storyboard-based application, you will often want to do a little preparation before navigation
  override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    let navigationController = segue.destinationViewController as! UINavigationController
    if let filtersViewController = navigationController.topViewController as? FiltersViewController {
      filtersViewController.delegate = self
      filtersViewController.filterPreferences = filterPreferences
    } else if let mapViewController = navigationController.topViewController as? MapViewController {
      mapViewController.filterPreferences = filterPreferences
      mapViewController.businesses = businesses
    }
  }

  // MARK: - Private members

  private func updateBusinesses() -> Void {
    Business.searchWithTerm(
      searchTerm,
      sort: filterPreferences.sort,
      categories: filterPreferences.categories,
      deals: filterPreferences.deals,
      distance: filterPreferences.distance) {
        (businesses: [Business]!, error: NSError!) -> Void in
        self.businesses = businesses
        self.tableView.reloadData()
    }
  }
}

// MARK: - Delegate extensions
extension BusinessesViewController: UISearchBarDelegate {
  func searchBar(searchBar: UISearchBar, textDidChange searchText: String) {
    self.searchTerm = searchText
    updateBusinesses()
  }
}

extension BusinessesViewController: UITableViewDataSource, UITableViewDelegate {
  func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return businesses?.count ?? 0
  }

  func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCellWithIdentifier("BusinessCell", forIndexPath: indexPath) as! BusinessCell
    cell.business = businesses[indexPath.row]
    return cell
  }

}

extension BusinessesViewController: FiltersViewControllerDelegate {
  func filtersViewController(filtersViewController: FiltersViewController, didUpdateFilters filterPreferences: FilterPreferences) {
    self.filterPreferences = filterPreferences
    updateBusinesses()
  }
}
