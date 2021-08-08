//
//  ViewController.swift
//  Capital-Cities-P16
//
//  Created by Łukasz Nycz on 05/08/2021.
//

import UIKit
import MapKit
import SafariServices

class ViewController: UIViewController, MKMapViewDelegate {

    @IBOutlet var mapView: MKMapView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        let london = Capital(title: "London", coordinate: CLLocationCoordinate2D(latitude: 51.50722, longitude: -0.1275), info: "Home to 2012 Summer Olimpics.")
        let oslo = Capital(title: "Oslo", coordinate: CLLocationCoordinate2D(latitude: 59.95, longitude: 10.75), info: "It was founded over 1000 years ago.")
        let paris = Capital(title: "Paris", coordinate: CLLocationCoordinate2D(latitude: 48.8567, longitude: 2.3508), info: "Often called City of Light.")
        let rome = Capital(title: "Rome", coordinate: CLLocationCoordinate2D(latitude: 41.9, longitude: 12.5), info: "Has a whole country inside it.")
        let washington = Capital(title: "Washington DC", coordinate: CLLocationCoordinate2D(latitude: 48.895111, longitude: -77.036667), info: "Named after George himself.")
            
        mapView.addAnnotations([london, oslo, paris, rome, washington])
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(mapViewType))
       

    }
    @objc func mapViewType() {
        let ac = UIAlertController(title: "Choose map view type", message: nil, preferredStyle: .actionSheet)
        ac.addAction(UIAlertAction(title: "Hybrid", style: .default, handler: viewType))
        ac.addAction(UIAlertAction(title: "HybridFlyover", style: .default, handler: viewType))
        ac.addAction(UIAlertAction(title: "MutedStandard", style: .default, handler: viewType))
        ac.addAction(UIAlertAction(title: "Satellite", style: .default, handler: viewType))
        ac.addAction(UIAlertAction(title: "SatelliteFlyover", style: .default, handler: viewType))
        ac.addAction(UIAlertAction(title: "Standard", style: .default, handler: viewType))
        ac.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        present(ac, animated: true)

    }
    func viewType(action: UIAlertAction) {
        switch action.title {
        case "Hybrid":
            mapView.mapType = .hybrid
        case "HybridFlyover":
            mapView.mapType = .hybridFlyover
        case "MutedStandard":
            mapView.mapType = .mutedStandard
        case "Satellite":
            mapView.mapType = .satellite
        case "SatelliteFlyover":
            mapView.mapType = .satelliteFlyover
        case "Standard":
            mapView.mapType = .standard
        default:
            mapView.mapType = .standard
        }
    }

        func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
            guard annotation is Capital else {return nil}
             let identifier = "Capital"
            
            var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier) as? MKPinAnnotationView
            
            if annotationView == nil {
                annotationView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: identifier)
                annotationView?.canShowCallout = true
                
                let btn = UIButton(type: .detailDisclosure)
                annotationView?.rightCalloutAccessoryView = btn
                
            } else {
                annotationView?.annotation = annotation
        }
            annotationView?.pinTintColor = .systemBlue
         return annotationView
    }
    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
        guard let capital = view.annotation as? Capital else {return}
        let capitalTitle = capital.title!
        
        let vc = SFSafariViewController(url: URL(string: "https://en.wikipedia.org/wiki/" + "\(capitalTitle)")!)
        present(vc, animated: true)
    }

}
