//
//  ViewController.swift
//  ATM&Branch
//
//  Created by sunny on 10/22/16.
//  Copyright © 2016 sunny. All rights reserved.
//

import UIKit
import CoreLocation

class ViewController: UIViewController,CLLocationManagerDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        

        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func toMap(_ sender: AnyObject) {
        
        self.performSegue(withIdentifier: "toMap", sender: self)
        
    }
    
}

