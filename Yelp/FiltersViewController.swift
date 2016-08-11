//
//  FiltersViewController.swift
//  Yelp
//
//  Created by kate_odnous on 8/9/16.
//  Copyright © 2016 Timothy Lee. All rights reserved.
//

import UIKit

class FiltersViewController: UIViewController {

  @IBOutlet weak var tableView: UITableView!

//  let filterCategories = [
//    "Categories",
//    "Sort",
//    "Distance",
//    "Deals",
//  ]

  var filters = [
    CategoriesFilter()
  ]

  var filterSelections = [Filter:[String:Bool]]()

  override func viewDidLoad() {
    super.viewDidLoad()
    tableView.delegate = self
    tableView.dataSource = self
    tableView.rowHeight = UITableViewAutomaticDimension
    tableView.estimatedRowHeight = 200
  }

  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }

  @IBAction func onCancelButton(sender: AnyObject) {
    dismissViewControllerAnimated(true, completion:nil)
  }

  @IBAction func onSearchButton(sender: AnyObject) {
    dismissViewControllerAnimated(true, completion:nil)
  }

  /*
   // MARK: - Navigation

   // In a storyboard-based application, you will often want to do a little preparation before navigation
   override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
   // Get the new view controller using segue.destinationViewController.
   // Pass the selected object to the new view controller.
   }
   */

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
    cell.filter = filter
    cell.filterCategory = filter.categories[indexPath.row]
    cell.onSwitch.on = filterSelections[filter]?[cell.filterCategory!.name] ?? false
    cell.delegate = self
    return cell
  }
}


extension FiltersViewController: SwitchCellDelegate {
  func switchCell(switchCell: SwitchCell, didChangeValue value: Bool) {
//    filterSelections[switchCell.filter!]?[switchCell.filterCategory!.name] = value
    if filterSelections[switchCell.filter!] == nil {
      filterSelections[switchCell.filter!] = [switchCell.filterCategory!.name: value]
    } else {
      filterSelections[switchCell.filter!]![switchCell.filterCategory!.name] = value
    }
    print(filterSelections)
  }
}