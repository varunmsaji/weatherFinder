//
//  DisplayViewController.swift
//  WeatheApplication
//
//  Created by Varun M S on 08/11/17.
//  Copyright © 2017 Tectra. All rights reserved.
//

import UIKit
import CoreLocation
import MapKit

class displayViewController: UIViewController,CLLocationManagerDelegate {
    var searchtext:String = ""
    var searchCity:String = ""
    let manager = CLLocationManager()
    //MARK: outlet properties
    
    @IBOutlet weak var imagelabel: UIImageView!
    
    @IBOutlet weak var namelabel: UILabel!
    
    @IBOutlet weak var conditionlabel: UILabel!
    
    
    @IBOutlet weak var humidity: UILabel!
    
    @IBOutlet weak var wind: UILabel!
    
    @IBOutlet weak var temperatureLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        namelabel.isHidden = true
        conditionlabel.isHidden = true
        if locationBool == false
        {
            
            getdata(term: searchtext)
        }
        else{
            manager.delegate = self
            manager.delegate = self
            manager.desiredAccuracy = kCLLocationAccuracyBest
            manager.requestWhenInUseAuthorization()
            manager.startUpdatingLocation()
            
            
        }
        
        
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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






extension displayViewController
{
    func getdata(term:String){
        
        
        let url = URL(string:"http://api.apixu.com/v1/current.json?key=663191e44ae84f8281425027173110&q=\(term.replacingOccurrences(of: " ", with: "%20"))")
        print(term)
        let urlSession = URLSession.shared.dataTask(with: url!) { (data, response, error) in
            do{
                let json =  try JSONSerialization.jsonObject(with: data!, options: []) as! [String:Any]
                print(json)
                let current = json["current"] as! [String:Any]
                let condiotion = current["condition"] as! [String:Any]
                let text = condiotion["text"] as! String
                let icon = condiotion["icon"] as! String
                
                let icontosent = "http:\(icon)"
                let humidity = current["humidity"]
                let temp = current["temp_c"]
                 let temptoprint = String (describing: temp)
                    
                
                let humidityToPrint = String ( describing: humidity)
                
                self.desplaymovieimage(url: icontosent)
                DispatchQueue.main.async {
                    self.namelabel.isHidden = false
                    self.conditionlabel.isHidden = false
                    self.conditionlabel.text = text
                    self.namelabel.text = self.searchtext
                    self.temperatureLabel.text = temptoprint
                   
                    
                    self.humidity.text = humidityToPrint
                }
                
            }catch {
                print(error)
            }
            
        }
        urlSession.resume()
    }
    
    func desplaymovieimage(url:String)
    {
        let url:String = (URL(string:url)?.absoluteString)!
        URLSession.shared.dataTask(with: URL(string:url)!) { (data, responce, error) in
            if error != nil
            {
                print(error)
                return
            }
            DispatchQueue.main.async(execute: {
                let image = UIImage(data:data!)
                self.imagelabel.image = image
            })
            }.resume()
        
    }
}









extension displayViewController
{
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        let location = locations[0]
        CLGeocoder().reverseGeocodeLocation(location) { (placemark, error) in
            if error != nil
            {
                print(error)
            }
            else
            {
                let place = placemark![0]
                let city = place.addressDictionary!["City"] as! String
                
                
                
                country = place.country
                print(country)
                self.searchtext = city
                self.getdata(term: city)
                locationBool = false
                
            }
        }
        manager.stopUpdatingLocation()
    }
    
}
