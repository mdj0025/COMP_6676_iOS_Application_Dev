//
//  MapDataManager.swift
//  FinalProjectmdj0025Su21
//
//  Created by Michael Johnson on 7/25/21.
//

import Foundation
import MapKit

class MapDataManager: DataManager
{
    fileprivate var items:[MapItem] = []
    var annotations:[MapItem] { return items }
    
    func fetch(completion:(_ annotations:[MapItem]) -> ())
    {
        if items.count > 0
        {
            items.removeAll()
        }
        for data in load(file: "MapLocations")
        {
            items.append(MapItem(dict: data))
        }
        completion(items)
    }
    
    func currentRegion(latDelta: CLLocationDegrees, longDelta: CLLocationDegrees) -> MKCoordinateRegion
    {
        guard let item = items.first else
        {
           return MKCoordinateRegion()
        }
        let span = MKCoordinateSpan(latitudeDelta: latDelta, longitudeDelta: longDelta)
        return MKCoordinateRegion(center: item.coordinate, span:span)
    }
}
