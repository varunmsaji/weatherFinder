//
//  SearchViewController.swift
//  WeatheApplication
//
//  Created by Varun M S on 08/11/17.
//  Copyright © 2017 Tectra. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation


var country:String?
var  locationBool:Bool = false


class ViewController: UIViewController,UISearchBarDelegate,CLLocationManagerDelegate {
    //MARK: outlet properties
    
    @IBOutlet weak var weatherlabel: UILabel!
    @IBOutlet weak var searchbar: UISearchBar!
    
    @IBOutlet weak var locatebutton: UIButton!
    let manager = CLLocationManager()
    
    
    @IBAction func locatemebutton(_ sender: Any) {
        
        
        locationBool = true
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        let des = segue.destination as! displayViewController
        des.searchtext = self.searchbar.text!
        
        
        
    }
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
}


extension ViewController
{
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
        
        performSegue(withIdentifier: "mainto", sender: nil)
        
    }
    
}




