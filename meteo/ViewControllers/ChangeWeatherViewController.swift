//
//  ChangeWeatherViewController.swift
//  meteo
//
//  Created by Ihor Sihuta on 9/13/18.
//  Copyright © 2018 hustlehard. All rights reserved.
//

import UIKit

protocol ChangeLocationDelegate {
    func changeLocation(new: String)
}

class ChangeWeatherViewController: UIViewController {

    @IBOutlet weak var cityNameTextField: UITextField!
    
    var delegate: ChangeLocationDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func getWeather(_ sender: Any) {
        let newCityName = cityNameTextField.text!
        delegate?.changeLocation(new: newCityName)
        dismiss(animated: true, completion: nil)
    }
    
}
