//
//  DetailTableViewController.swift
//  ATM&Branch
//
//  Created by sunny on 10/22/16.
//  Copyright © 2016 sunny. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    @IBAction func backBtn(_ sender: AnyObject) {
        performSegue(withIdentifier: "backToMap", sender: self)
    }
    var dict = [String:AnyObject]()
    override func viewDidLoad() {
        super.viewDidLoad()

        //set navigation bar background title color
        UINavigationBar.appearance().setBackgroundImage(UIImage(named: "nav")!.resizableImage(withCapInsets: UIEdgeInsetsMake(0, 0, 0, 0), resizingMode: .stretch), for: .default)

        UINavigationBar.appearance().titleTextAttributes = [NSForegroundColorAttributeName : UIColor.white]

        //don't show blank over tableview
        self.automaticallyAdjustsScrollViewInsets = false
        //don't show extra tableview lines
        self.tableView.tableFooterView = UIView()

    }



    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }



}

extension DetailViewController:UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print("\(self.dict["locationType"])")
            if(self.dict["locationType"] as! String == "atm"){
                return 5
            }
            else{
                return 7
            }
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if tableView.numberOfRows(inSection: 0) == 5 {
            if indexPath.row == 0 {
                
                let cell = tableView.dequeueReusableCell(withIdentifier: "titlecell") as! TitleTableViewCell
                cell.titleLbl.text = self.dict["label"] as! String
                return cell
            }
            else if indexPath.row == 1{
                
                let cell = tableView.dequeueReusableCell(withIdentifier: "addcell") as! AddTableViewCell
                cell.addLbl.text = "Address"
                cell.detailLbl.text = "\(self.dict["address"] as! String)\n\(self.dict["city"] as! String),\(self.dict["state"] as! String)\n\(self.dict["zip"] as! String)"
                return cell
                
            }
            else if indexPath.row == 2{
                
                let cell = tableView.dequeueReusableCell(withIdentifier: "singlecell") as! SingleTableViewCell
                cell.nameLbl.text = "Distance"
                cell.detaiLbl.text = "\(self.dict["distance"]!) miles"
                return cell
                
            }else if indexPath.row == 3{
                
                let cell = tableView.dequeueReusableCell(withIdentifier: "singlecell") as! SingleTableViewCell
                cell.nameLbl.text = "Access"
                cell.detaiLbl.text = "\(self.dict["access"]!)"
                return cell
            
            }else{
                
                let cell = tableView.dequeueReusableCell(withIdentifier: "addcell") as! AddTableViewCell
                cell.addLbl.text = "Service"
                if(self.dict["services"] == nil)
                {
                    cell.detailLbl.text = "No Service Infomation"
                }else{
                    let service = self.dict["services"] as! [String]
                    cell.detailLbl.text = "\(service[0]) \n \(service[1]) \n \(service[2])"
                }
                return cell
                
            }
        }else{
            
            if indexPath.row == 0 {
                
                let cell = tableView.dequeueReusableCell(withIdentifier: "titlecell") as! TitleTableViewCell
                cell.titleLbl.text = self.dict["label"] as! String
                return cell
                
            }
            else if indexPath.row == 1{
                
                let cell = tableView.dequeueReusableCell(withIdentifier: "addcell") as! AddTableViewCell
                cell.addLbl.text = "Address"
                cell.detailLbl.text = "\(self.dict["address"] as! String)\n\(self.dict["city"] as! String),\(self.dict["state"] as! String)\n\(self.dict["zip"] as! String)"
                return cell
                
            }
            else if indexPath.row == 2{
                
                let cell = tableView.dequeueReusableCell(withIdentifier: "singlecell") as! SingleTableViewCell
                cell.nameLbl.text = "Phone"
                cell.detaiLbl.text = "\(self.dict["phone"]!)"
                return cell
                
            }
            else if indexPath.row == 3{
                
                let cell = tableView.dequeueReusableCell(withIdentifier: "singlecell") as! SingleTableViewCell
                cell.nameLbl.text = "Distance"
                cell.detaiLbl.text = "\(self.dict["distance"]!) miles"
                return cell
                
            }
            else if(indexPath.row == 4 )
            {
                let cell = tableView.dequeueReusableCell(withIdentifier: "singlecell") as! SingleTableViewCell
                cell.nameLbl.text = "ATMs"
                cell.detaiLbl.text = "\(self.dict["atms"]!)"
                return cell
                
            }
            else if(indexPath.row == 5 )
            {

                let cell = tableView.dequeueReusableCell(withIdentifier: "lobbycell") as! LobTableViewCell
                cell.lobLbl.text = "Lobby"
                let lobby = self.dict["lobbyHours"] as! [String]
                
                cell.detailLbl.text = "Sun: Closed \n Mon: \(lobby[1]) \n Tue: \(lobby[2]) \n Wed: \(lobby[3]) \n Thu: \(lobby[4]) \n Fri: \(lobby[5]) \n Sat: \(lobby[6])"
                return cell
            }else{
                
                let cell = tableView.dequeueReusableCell(withIdentifier: "singlecell") as! SingleTableViewCell
                cell.nameLbl.text = "Type"
                cell.detaiLbl.text = "\(self.dict["type"]!)"
                return cell
                
            }
        }
        
    }
    
    //return height for different indexPath.row
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        if(self.dict["locationType"] as! String == "atm")
        {
            if(indexPath.row == 1)
            {
                return 72
            }else if(indexPath.row == 4){
                return 60
            }else{
                return 44
            }
        }else{
            if(indexPath.row == 1)
            {
                return 72
            }else if(indexPath.row == 5){
                return 168
            }else{
                return 44
            }
        }
        
    }
}
