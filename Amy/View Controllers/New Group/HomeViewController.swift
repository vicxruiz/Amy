//
//  HomeViewController.swift
//  Amy
//
//  Created by Victor  on 6/27/19.
//  Copyright © 2019 Victor . All rights reserved.
//

import Foundation
import UIKit
import FirebaseDatabase
import FirebaseAuth
import MapKit
class HomeViewController: UIViewController, MKMapViewDelegate {
    
    @IBOutlet weak var mealButton: UIButton!
    @IBOutlet weak var mapView: MKMapView!
    
    let locationManager = CLLocationManager()
    let regionInMeters: Double = 50000
    override func viewDidLoad() {
        super.viewDidLoad()
         mapView.delegate = self
        setUpViews()
        checkLocationServices()
        
    }
    
    @IBAction func mealButtonPressed(_ sender: Any) {
        print("Hello World")
    }
    
    func setUpViews() {
        mealButton.layer.masksToBounds = true
        mealButton.layer.cornerRadius = 7
    }
    
    func setUpLocationManager() {
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
    }
    
    func checkLocationServices() {
        print("done 2")
        if CLLocationManager.locationServicesEnabled() {
            setUpLocationManager()
            checkLocationAuthorization()
            print("done 3")
        }
        else {
            print("not done 1")
        }
    }
    
    func checkLocationAuthorization() {
        switch CLLocationManager.authorizationStatus() {
        case .authorizedWhenInUse:
            mapView.showsUserLocation = true
            centerViewOnUserLocation()
            locationManager.startUpdatingLocation()
            print("done 4")
            break
        case .denied:
            print("done 5")
            break
        case .notDetermined:
            print("done 6")
            locationManager.requestWhenInUseAuthorization()
            print("done done 6")
            break
        case .restricted:
            print("done 7")
            break
        case .authorizedAlways:
            print("done 8")
            break
        }
    }
    
    func gettingUserDirections() {
        guard let sourceCoordinates = locationManager.location?.coordinate else {return}
        let destinationCoordinates = CLLocationCoordinate2DMake(26.0095, -80.2204)
        let startingCoordinates = CLLocationCoordinate2DMake(26.0078, -80.2713)
        
        
        let sourcePlacemark = MKPlacemark(coordinate: sourceCoordinates)
        let destinationPlacemark = MKPlacemark(coordinate: destinationCoordinates)
        
        let sourceItem = MKMapItem(placemark: sourcePlacemark)
        let destinationItem = MKMapItem(placemark: destinationPlacemark)
        
        
        let directionRequest = MKDirections.Request()
        directionRequest.source = sourceItem
        directionRequest.destination = destinationItem
        directionRequest.transportType = .automobile
        
        let directions = MKDirections(request: directionRequest)
        directions.calculate { (response, error) in
            guard let response = response else {
                if let _ = error {
                    print("something went wrong")
                }
                print("nothing went wrong")
                return
            }
            
            let route = response.routes[0]
            self.mapView.addOverlay(route.polyline, level: MKOverlayLevel.aboveRoads)
            self.mapView.setCenter(route.polyline.coordinate, animated: true)
            //let rect = route.polyline.boundingMapRect
            //self.mapView.setRegion(MKCoordinateRegion.init(rect), animated: true)
        }
    }
    
    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        let renderer = MKPolylineRenderer(overlay: overlay)
        renderer.strokeColor = UIColor(r: 240, g: 128, b: 128)
        return renderer
    }
    
    func centerViewOnUserLocation() {
        print("done 9")
        if let location = locationManager.location?.coordinate {
            print("done 10")
            let region = MKCoordinateRegion(center: location, latitudinalMeters: regionInMeters, longitudinalMeters: regionInMeters)
            mapView.setRegion(region, animated: true)
        }
    }
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        // 2
        guard let annotation = annotation as? Artwork else { return nil }
        // 3
        let identifier = "marker"
        var view: MKMarkerAnnotationView
        // 4
        if let dequeuedView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier)
            as? MKMarkerAnnotationView {
            dequeuedView.annotation = annotation
            view = dequeuedView
        } else {
            // 5
            view = MKMarkerAnnotationView(annotation: annotation, reuseIdentifier: identifier)
            view.canShowCallout = true
            view.calloutOffset = CGPoint(x: -5, y: 5)
            view.rightCalloutAccessoryView = UIButton(type: .detailDisclosure)
        }
        return view
    }
    
    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView,
                 calloutAccessoryControlTapped control: UIControl) {
        let location = view.annotation as! Artwork
        let launchOptions = [MKLaunchOptionsDirectionsModeKey: MKLaunchOptionsDirectionsModeDriving]
        location.mapItem().openInMaps(launchOptions: launchOptions)
    }

}


extension HomeViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        checkLocationAuthorization()
    }
}
