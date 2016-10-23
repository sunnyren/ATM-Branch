//
//  File.swift
//  ATM&Branch
//
//  Created by sunny on 10/22/16.
//  Copyright © 2016 sunny. All rights reserved.
//

import Foundation

class JPLocationModel: NSObject {
    
    var lat: String?
    var lng: String?
    
    var locType: String?
    var distance: NSNumber?
    var label: String?
    var address: String?
    
    
    
    init(dict: [String: AnyObject])
    {
        super.init()
        setValuesForKeys(dict)
    }
    
    override func setValue(_ value: Any?, forUndefinedKey key: String) {
        
    }
    


}
