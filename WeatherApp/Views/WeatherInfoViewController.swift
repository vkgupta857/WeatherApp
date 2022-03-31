//
//  WeatherInfoViewController.swift
//  WeatherApp
//
//  Created on 28/03/22.
//  

import UIKit

class WeatherInfoViewController: UIViewController {
    
    var navigationTitle: String?
    
    lazy var viewModel: WeatherInfoVM = {
        return WeatherInfoVM()
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initVM()
        setupUI()
        debugPrint("currentCity ->", self.viewModel.currentCity)
        if let city = self.viewModel.currentCity {
            UserDefaultsManager.shared.addCityToUserDefaults(city: city)
        }
    }
    
    func initVM() {
        self.viewModel.locationKey = self.viewModel.currentCity?.key
        self.viewModel.getWeatherInfo()
    }
    
    func setupUI() {
        self.navigationItem.title = navigationTitle
        debugPrint(viewModel.latitude as Any, viewModel.longitude as Any)
    }
}
