//
//  MapItem.swift
//  FinalProjectmdj0025Su21
//
//  Created by Michael Johnson on 7/25/21.
//

import Foundation
import UIKit
import MapKit

class MapItem: NSObject, MKAnnotation
{
    var name: String?
    var lat: Double?
    var long: Double?
    var hours : [String : String]
    
    init(dict: [String:AnyObject])
    {
        if let name = dict["name"] as? String
        {
            self.name = name
        }
        if let lat = dict["lat"] as? Double
        {
            self.lat = lat
        }
        if let long = dict["long"] as? Double
        {
            self.long = long
        }

        if let hours = dict["hours"] as? [String : String]
        {
            self.hours = hours
        }
        else
        {
            // Initialize to empty to make xcode happy....
            print("Initialized to empty")
            self.hours = [:]
        }

    }
    
    var coordinate: CLLocationCoordinate2D {
        guard let lat = lat, let long = long else
        {
            return CLLocationCoordinate2D()
        }
        return CLLocationCoordinate2D(latitude: lat, longitude: long)
    }
    
    var title: String? {return name}
    
}
