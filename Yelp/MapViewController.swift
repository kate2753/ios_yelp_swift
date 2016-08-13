//
//  MapViewController.swift
//  Yelp
//
//  Created by kate_odnous on 8/12/16.
//  Copyright © 2016 Timothy Lee. All rights reserved.
//

import UIKit
import MapKit

class MapViewController: UIViewController {
  @IBOutlet weak var mapView: MKMapView!

  var businesses: [Business]?
  var filterPreferences = FilterPreferences()

  override func viewDidLoad() {
    super.viewDidLoad()

    // Do any additional setup after loading the view.
    let centerLocation = CLLocation(latitude: 37.7833, longitude: -122.4167)
    goToLocation(centerLocation)
    if let businesses = businesses{
      businesses.forEach(){ addBusinessAnnotation($0) }
    }
  }

  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }

  func goToLocation(location: CLLocation) {
    let span = MKCoordinateSpanMake(0.1, 0.1)
    let region = MKCoordinateRegionMake(location.coordinate, span)
    mapView.setRegion(region, animated: false)
  }

  func addBusinessAnnotation(busines: Business) {
    if busines.latitude != nil && busines.latitude != nil {
      let coordinate = CLLocationCoordinate2D(latitude: busines.latitude!, longitude: busines.longitude!)
      let annotation = MKPointAnnotation()
      annotation.coordinate = coordinate
      annotation.title = busines.name
      mapView.addAnnotation(annotation)
    }
  }

  /*
   // MARK: - Navigation

   // In a storyboard-based application, you will often want to do a little preparation before navigation
   override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
   // Get the new view controller using segue.destinationViewController.
   // Pass the selected object to the new view controller.
   }
   */
  @IBAction func onListView(sender: AnyObject) {
    dismissViewControllerAnimated(true, completion: nil)
  }

}