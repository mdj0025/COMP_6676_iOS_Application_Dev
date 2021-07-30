//
//  ViewController.swift
//  FinalProjectmdj0025Su21
//
//  Created by Michael Johnson on 7/25/21.
//

import UIKit
import MapKit
import FloatingPanel

class ViewController: UIViewController,MKMapViewDelegate, FloatingPanelControllerDelegate {

    @IBOutlet weak var mapView: MKMapView!
    
    let locationManager = CLLocationManager()
    
    var currentCoordinate: CLLocationCoordinate2D?
    
    let manager = MapDataManager()
    
    var mainFloatingPanel : ContentViewController?
    
    var itemFloatingPanel : ItemViewController?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initialize()
        // Do any additional setup after loading the view.
    }
    
    func initialize()
    {
        manager.fetch(
            completion: {
                (annotations) in addMap(annotations)
            })
        configureLocationServices()
        configureFloatingPanel()
    }

    func configureFloatingPanel()
    {
        let fpc = FloatingPanelController()
        fpc.delegate = self
        guard let contentVC = storyboard?.instantiateViewController(identifier: "fpc_content") as? ContentViewController
        else
        {
            return
        }
        fpc.set(contentViewController: contentVC)
        fpc.addPanel(toParent: self)
        contentVC.data = manager.annotations
        contentVC.parentVC = self

        mainFloatingPanel = contentVC
        mainFloatingPanel?.floatingPanelController = fpc
    }

    func readdFloatingPanel()
    {
        mainFloatingPanel?.floatingPanelController?.set(contentViewController: mainFloatingPanel)
        mainFloatingPanel?.floatingPanelController?.addPanel(toParent: self)
    }
    
    func configureLocationServices()
    {
        locationManager.delegate = self
        
        let status = locationManager.authorizationStatus
        
        if status == .notDetermined
        {
            locationManager.requestAlwaysAuthorization()
        }
        else if status == .authorizedAlways || status == .authorizedWhenInUse
        {
            mapView.showsUserLocation = true
            locationManager.desiredAccuracy = kCLLocationAccuracyBest
            locationManager.startUpdatingLocation()
        }
    }
    
    func highlightMapItem(item: MapItem)
    {
        let annotationArr = manager.annotations
        
        for annotation in annotationArr
        {
            if annotation.name == item.name
            {
                let span = MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01)
                let adjustedCoordinate : CLLocationCoordinate2D = CLLocationCoordinate2D(latitude: item.coordinate.latitude - 0.005, longitude: item.coordinate.longitude)
                let coordinate = MKCoordinateRegion(center: adjustedCoordinate, span:span)
                mapView.setRegion(coordinate, animated: true)

                mainFloatingPanel?.removeFromParent()
                mainFloatingPanel?.view.removeFromSuperview()
                mainFloatingPanel?.floatingPanelController?.removeFromParent()
                mainFloatingPanel?.floatingPanelController?.view.removeFromSuperview()
                
                let fpc = FloatingPanelController()
                fpc.delegate = self
                guard let contentVC = storyboard?.instantiateViewController(identifier: "item_fpc_content") as? ItemViewController
                else
                {
                    return
                }
                fpc.set(contentViewController: contentVC)
                contentVC.data = item
                contentVC.parentVC = self
                fpc.addPanel(toParent: self)

                itemFloatingPanel = contentVC
                itemFloatingPanel?.floatingPanelController = fpc
            }
        }
    }
    
    func addMap(_ annotations: [MapItem])
    {
        mapView.setRegion(manager.currentRegion(latDelta: 0.45, longDelta: 0.45), animated: true)
        mapView.addAnnotations(manager.annotations)
    }
}

extension ViewController: CLLocationManagerDelegate
{
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation])
    {
        guard let latestLocation = locations.first else { return }
        currentCoordinate = latestLocation.coordinate
        
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus)
    {
        
    }
}
