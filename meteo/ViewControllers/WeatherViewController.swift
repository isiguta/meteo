//
//  WeatherViewController.swift
//  meteo
//
//  Created by Ihor Sihuta on 9/13/18.
//  Copyright © 2018 hustlehard. All rights reserved.
//

import UIKit
import CoreLocation
import Alamofire
import SwiftyJSON

class WeatherViewController: UIViewController, CLLocationManagerDelegate {
    
    let API_URL = "http://api.openweathermap.org/data/2.5/weather"
    let APP_ID = "bdab47e4ecb2981b680b172f91970841"
    
    let locationManager = CLLocationManager()
    let weatherDataModel = WeatherDataModel()
    
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
    
    func requestWeather(url: String, parameters: [String: String]) {
        
        Alamofire.request(url, method: .get, parameters: parameters, encoding: URLEncoding.default).responseJSON {
            response in
            if response.result.isSuccess {
                let data: JSON = JSON(response.result.value!)
                print(data)
                self.updateWeather(json: data)
                self.updateUI()
            }
            else {
                print("\(response.error)")
            }
        }
    }
    
    func updateWeather(json: JSON) {
        if let temperatureResult = json["main"]["temp"].double {
            weatherDataModel.temperature = Int(temperatureResult - 273.15)
            weatherDataModel.city = json["name"].stringValue
            weatherDataModel.condition = json["weather"][0]["id"].intValue
            weatherDataModel.weatherIconName = weatherDataModel.updateWeatherIcon(condition: weatherDataModel.condition)
        }
        else {
            cityLabel.text = "Data unavailable"
        }
    }
    
    func updateUI() {
        cityLabel.text = weatherDataModel.city
        temperatureLabel.text = String(weatherDataModel.temperature)
        weatherIcon.image = UIImage(named: weatherDataModel.weatherIconName)
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
            let params: [String: String] = ["lat": String(latitude), "lon": String(longitude), "appid": APP_ID]
            
            requestWeather(url: API_URL, parameters: params)
        }
    }
    
    //Show error if location is unavaliable
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        
    }
}
