//
//  CarpLocation.swift
//  CateFresh
//
//  Created by Jeff Pan on 10/29/16.
//  Copyright © 2016 Connor Pan. All rights reserved.
//

import UIKit
import MapKit

class CarpLocation: NSObject, MKAnnotation {
    var title: String?
    var coordinate: CLLocationCoordinate2D
    var info: String
    
    init(title: String, coordinate: CLLocationCoordinate2D, info : String) {
        self.title = title
        self.coordinate = coordinate
        self.info = info
    }
}
