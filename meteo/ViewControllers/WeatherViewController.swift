//
//  WeatherViewController.swift
//  meteo
//
//  Created by Ihor Sihuta on 9/13/18.
//  Copyright © 2018 hustlehard. All rights reserved.
//

import UIKit
import CoreLocation

class WeatherViewController: UIViewController, CLLocationManagerDelegate {
    
    let API_URL = "api.openweathermap.org/data/2.5/weather"
    let APP_ID = "bdab47e4ecb2981b680b172f91970841"
    
    let locationManager = CLLocationManager()
    
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var weatherIcon: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.distanceFilter = 100
        locationManager.desiredAccuracy = kCLLocationAccuracyHundredMeters
        locationManager.startUpdatingLocation()
    }
    
    //Get device's GPS location
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let latestLocation = locations[locations.count - 1]
        if latestLocation.horizontalAccuracy > 0 {
            locationManager.stopUpdatingLocation()
            
            //getting coordinates
            let latitude = latestLocation.coordinate.latitude
            let longitude = latestLocation.coordinate.longitude
            
            //parameters for OpenWeaether API
            let parameters: [String: String] = ["lat": String(latitude), "lon": String(longitude), "appid": APP_ID]
        }
    }
    
    //Show error if location is unavaliable
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        
    }
}
