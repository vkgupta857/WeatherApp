//
//  WeatherInfoViewController.swift
//  WeatherApp
//
//  Created on 28/03/22.
//  

import UIKit

class WeatherInfoViewController: UIViewController {

    var navigationTitle: String?
    var latitude: Double?
    var longitude: Double?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = navigationTitle
        debugPrint(latitude, longitude)
    }
}
