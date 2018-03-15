//
//  MapViewController.swift
//  Flimmer
//
//  Created by Jesper Kramming on 2018-03-08.
//  Copyright © 2018 NegativeZero. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

protocol MapViewControllerDelegate {
    func mapViewLocation(location: CLLocationCoordinate2D)
}

class MapViewController: UIViewController, CLLocationManagerDelegate {

    @IBOutlet weak var map: MKMapView!

    let locationManager = CLLocationManager();
   
    var delegate: MapViewControllerDelegate?

    override func viewDidLoad() {
        super.viewDidLoad()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
        
        self.map.showsPointsOfInterest = true
        self.map.isZoomEnabled = true
        
        self.navigationItem.title = "Search by location"
    }
    
    @IBAction func onTapped(_ sender: UITapGestureRecognizer) {
        
        let location = sender.location(in: self.map)
        let locCoord = self.map.convert(location, toCoordinateFrom: self.map)
        let annotation = MKPointAnnotation()
        
        annotation.coordinate = locCoord
        annotation.title = "Search here..."
        
        delegate?.mapViewLocation(location: locCoord)
        self.navigationController?.popViewController(animated: true)
        
        self.map.removeAnnotations(self.map.annotations)
        self.map.addAnnotation(annotation)
    }

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
       let location = locations.last
        
        let span: MKCoordinateSpan = MKCoordinateSpanMake(0.05, 0.05)
        let currentLocation = CLLocationCoordinate2DMake((location?.coordinate.latitude)!, (location?.coordinate.longitude)!)
        let region = MKCoordinateRegionMake(currentLocation, span)
        
        self.map.setRegion(region, animated: true)
        self.map.showsUserLocation = true
        self.map.showsScale = true
        
        locationManager.stopUpdatingLocation()
    }
}

