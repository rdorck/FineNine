//
//  VineyardsViewController.swift
//  FineNine
//
//  Created by Robert Rock on 12/12/15.
//  Copyright © 2015 Robert Rock. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class VineyardsViewController: UIViewController, MKMapViewDelegate, CLLocationManagerDelegate, UINavigationControllerDelegate {

    @IBOutlet weak var menuButton: UIBarButtonItem!
    @IBOutlet weak var map: MKMapView!
    
    let locationManager = CLLocationManager()
    

    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationController?.navigationBar.barTintColor = UIColor.purpleColor()
        self.navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.whiteColor()]
        menuButton.target = self.revealViewController()
        menuButton.action = "revealToggle:"
        self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        
        // User's location
        
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        //locationManager.requestWhenInUseAuthorization()
        locationManager.requestAlwaysAuthorization()
        locationManager.startUpdatingLocation()
        
        
        // Chadsford Winery -> 39.8725905,-75.6267942,
        
        let latitude: CLLocationDegrees = 39.8725905
        let longitude: CLLocationDegrees = -75.6267942
        let location: CLLocationCoordinate2D = CLLocationCoordinate2DMake(latitude, longitude)
        
        let latitudeDelta: CLLocationDegrees = 0.03
        let longitudeDelta: CLLocationDegrees = 0.03
        let span: MKCoordinateSpan = MKCoordinateSpanMake(latitudeDelta, longitudeDelta)
        
        let region: MKCoordinateRegion = MKCoordinateRegionMake(location, span)
        
        map.setRegion(region, animated: true)
        
        let chadsFord = MKPointAnnotation()
        chadsFord.coordinate = location
        chadsFord.title = "Chadsford Winery"
        
        map.addAnnotation(chadsFord)
        
        
        // Add Gesture Recognizer
        let longPress = UILongPressGestureRecognizer(target: self, action: "mapLongPress:")
        longPress.minimumPressDuration = 1.5
        map.addGestureRecognizer(longPress)
        
        
    } // END of viewDidLoad()
    
    
    func mapLongPress(recognizer: UIGestureRecognizer) {
        //print("Long press detected.")
        
        let touchedAt = recognizer.locationInView(self.map)
        let touchedAtCoord: CLLocationCoordinate2D = map.convertPoint(touchedAt, toCoordinateFromView: self.map)
        
        let newPin = MKPointAnnotation()
        newPin.coordinate = touchedAtCoord
        map.addAnnotation(newPin)
        
    } 
    
    
    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        //print(locations)
        
        var currentLocation: CLLocation = locations[0] as! CLLocation
        
        let latitude = currentLocation.coordinate.latitude
        let longitude = currentLocation.coordinate.longitude
        let location: CLLocationCoordinate2D = CLLocationCoordinate2DMake(latitude, longitude)
        
        let latitudeDelta: CLLocationDegrees = 0.03
        let longitudeDelta: CLLocationDegrees = 0.03
        
        let span: MKCoordinateSpan = MKCoordinateSpanMake(latitudeDelta, longitudeDelta)
        
        let region: MKCoordinateRegion = MKCoordinateRegionMake(location, span)
        
        self.map.setRegion(region, animated: true)
        
    } // END of locationManager
    
    
    
    
    
    
    
    
    
    
}
