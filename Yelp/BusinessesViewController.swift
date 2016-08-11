//
//  BusinessesViewController.swift
//  Yelp
//
//  Created by Timothy Lee on 4/23/15.
//  Copyright (c) 2015 Timothy Lee. All rights reserved.
//

import UIKit

class BusinessesViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

  @IBOutlet weak var tableView: UITableView!
  var businesses: [Business]!
  var filterPreferences = FilterPreferences()

  override func viewDidLoad() {
    super.viewDidLoad()

    tableView.delegate = self
    tableView.dataSource = self
    tableView.rowHeight = UITableViewAutomaticDimension
    tableView.estimatedRowHeight = 120

    updateBusinesses(nil, categories: nil, deals: nil)
  }

  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }

  func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return businesses?.count ?? 0
  }

  func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCellWithIdentifier("BusinessCell", forIndexPath: indexPath) as! BusinessCell
    cell.business = businesses[indexPath.row]
    return cell
  }

  // MARK: - Navigation

  // In a storyboard-based application, you will often want to do a little preparation before navigation
  override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    let navigationController = segue.destinationViewController as! UINavigationController
    let filtersViewController = navigationController.topViewController as! FiltersViewController
    filtersViewController.delegate = self
    filtersViewController.filterPreferences = filterPreferences
  }

  private func updateBusinesses(sort: YelpSortMode?, categories: [String]?, deals: Bool? ) -> Void {
    Business.searchWithTerm("Restaurants", sort: sort, categories: categories, deals: deals) {
      (businesses: [Business]!, error: NSError!) -> Void in
      self.businesses = businesses
      self.tableView.reloadData()
    }
  }
}

extension BusinessesViewController: FiltersViewControllerDelegate {
  func filtersViewController(filtersViewController: FiltersViewController, didUpdateFilters filterPreferences: FilterPreferences) {
    updateBusinesses(filterPreferences.sort, categories: filterPreferences.categories, deals: nil)
  }
}