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

  override func viewDidLoad() {
    super.viewDidLoad()
    tableView.delegate = self
    tableView.dataSource = self


    // Do any additional setup after loading the view.
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
    cell.switchLabel.text = filters[indexPath.section].categories[indexPath.row].title
    return cell
  }
}
