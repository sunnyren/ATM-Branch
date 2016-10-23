//
//  MapViewController.swift
//  ATM&Branch
//
//  Created by sunny on 10/22/16.
//  Copyright © 2016 sunny. All rights reserved.
//

import UIKit
import CoreLocation
import MapKit

class MapViewController: UIViewController,MKMapViewDelegate,CLLocationManagerDelegate {
    
    var lat: Double?
    var lng: Double?
    var annotationList: [JPAnnotationModel]?
    var locationList: [JPLocationModel]?
    var detailDict = [String: Any]()
    //var navBar: UINavigationBar = UINavigationBar()
    var searchString:String?
    let geoCoder = CLGeocoder()


    override func viewDidLoad() {
        super.viewDidLoad()

        myMap.userTrackingMode = .follow
        self.mySearch.delegate = self

        //set navigation bar background title color
        UINavigationBar.appearance().setBackgroundImage(UIImage(named: "nav")!.resizableImage(withCapInsets: UIEdgeInsetsMake(0, 0, 0, 0), resizingMode: .stretch), for: .default)
        
        UINavigationBar.appearance().titleTextAttributes = [NSForegroundColorAttributeName : UIColor.white]
        

    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        //request for Authorization get current coordinate
        mgr.delegate = self
        mgr.requestAlwaysAuthorization()
        mgr.startUpdatingLocation()
        

    }


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
   
    @IBOutlet weak var mySearch: UISearchBar!
    @IBOutlet weak var myMap: MKMapView!
    
    //parse API with AFNetworking and add annotation
    func loadData(latt:Double,lngg:Double) -> Void{
        let url = "https://m.chase.com/PSRWeb/location/list.action"
        let manager = AFHTTPSessionManager()
        
        let parameters = NSMutableDictionary()

        parameters["lat"] = "\(latt)"
        parameters["lng"] = "\(lngg)"
        
        manager.get(url, parameters: parameters, progress: { (progress) in
            print("\(progress)")
            }, success: { (dataTask, object) in
                if(object == nil)
                {
                    print("no data")
                }else{
                    let data = object as! [String: AnyObject]
                    guard let resultArray = data["locations"] else{
                        print("no locations")
                        return
                    }
            
                    let locationArray = resultArray as! [[String: AnyObject]]
                    var models = [JPLocationModel]()
                    var annoModels = [JPAnnotationModel]()
                    for model in locationArray
                    {
                        let info = JPLocationModel(dict: model)
                        models.append(info)
                        let lat = Double(info.lat!)
                        let lng = Double(info.lng!)
                        self.detailDict = ["address": info.address!,
                                           "city":model["city"],
                                           "state": model["state"],
                                           "zip": model["zip"],
                                           "phone":model["phone"],
                                           "distance": model["distance"],
                                           "atm": model["atm"],
                                           "lobbyHours": model["lobbyHrs"],
                                           "driveUpHours": model["driveUpHrs"],
                                           "locationType": info.locType,
                                           "type": model["type"],
                                           "label":model["label"],
                                           "access":model["access"],
                                           "services":model["services"],
                                            "atms":model["atms"]]
                        
                        let coordinate = CLLocationCoordinate2D(latitude:CLLocationDegrees(lat!),longitude: CLLocationDegrees(lng!))
                        let annotation = JPAnnotationModel(coordinate: coordinate, title: info.address!, subtitle: info.label!,icon: info.locType,infoDict:self.detailDict as [String : AnyObject])
                        annoModels.append(annotation)
                    }
                    self.locationList = models
                    self.annotationList = annoModels
                    
                    DispatchQueue.main.async {
                        self.addAnnotation()
                    }
                }
                
                
        }) { (dataTask, error) in
            print(error.localizedDescription)
        }

    }
    @IBAction func backBtn(_ sender: AnyObject) {
        self.performSegue(withIdentifier: "toLogin", sender: self)
    }
    
    //add annotation after get annotation result list
    func addAnnotation() -> Void{
        for anno in self.annotationList!{
            let anno = JPAnnotationModel(coordinate: anno.coordinate, title: anno.title!, subtitle: anno.subtitle!, icon: anno.icon!,infoDict: anno.infoDict!)
            myMap.addAnnotation(anno)
        }
    }
    
    //customized annotation set image
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        
        if annotation.isKind(of: JPAnnotationModel.self) == true {
            let temp = annotation as! JPAnnotationModel
            let anno = MKAnnotationView(annotation: annotation, reuseIdentifier: "my")
            anno.canShowCallout = true
            anno.image = UIImage(named: temp.icon!)
            anno.rightCalloutAccessoryView = UIButton(type: .detailDisclosure)
            
            return anno
        }
        return nil
    }
    
    //detail button func
    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
        let temp = view.annotation as! JPAnnotationModel
        let anno = temp.infoDict! as [String:AnyObject]
        
        if (control as? UIButton)?.buttonType == UIButtonType.detailDisclosure {
            performSegue(withIdentifier: "toDetail", sender: anno)
        }
    }
    
    //pass data to destination
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toDetail" {
            let vc = segue.destination as! DetailViewController
            vc.dict = sender as! [String:AnyObject]
        }
    }
    
    lazy var mgr:CLLocationManager = {
        let temp = CLLocationManager()
        return temp
    }()
    
    //get user current coordinate
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        lat = locations.last?.coordinate.latitude
        lng = locations.last?.coordinate.longitude
        
        if (lat != nil && lng != nil){
            loadData(latt: self.lat!, lngg: self.lng!)
            mgr.stopUpdatingLocation()
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.mySearch.resignFirstResponder()
    }

    
    

}

extension MapViewController:UISearchBarDelegate{
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        self.searchString = searchText
        
    }
    
    //keyboard search func
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {

        geoCoder.geocodeAddressString(self.searchString!, completionHandler: {(placemarks,error) in
            if (error != nil || placemarks?.count == 0) {
                print(error?.localizedDescription)
                return
            }
            let placemark = placemarks?.first
            self.lat = placemark?.location?.coordinate.latitude
            self.lng = placemark?.location?.coordinate.longitude
            
            if self.lat != nil  && self.lng != nil {
                self.myMap.removeAnnotations(self.myMap.annotations)
                self.loadData(latt: self.lat!, lngg: self.lng!)
            }
        })

        
        mySearch.resignFirstResponder()
     }
}
