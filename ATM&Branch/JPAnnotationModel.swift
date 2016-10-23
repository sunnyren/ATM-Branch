//
//  myAnnotationView.swift
//  ATM&Branch
//
//  Created by sunny on 10/22/16.
//  Copyright © 2016 sunny. All rights reserved.
//

import UIKit
import MapKit

class JPAnnotationModel: NSObject,MKAnnotation {


    var coordinate:CLLocationCoordinate2D
    var title:String?
    var subtitle:String?
    var icon:String?
    var infoDict:[String:AnyObject]?
    
    init(coordinate: CLLocationCoordinate2D, title: String, subtitle: String, icon: String?,infoDict:[String:AnyObject]){
        self.coordinate = coordinate
        super.init()
        self.title = title
        self.subtitle = subtitle
        self.icon = icon
        self.infoDict = infoDict
    }


    
}
