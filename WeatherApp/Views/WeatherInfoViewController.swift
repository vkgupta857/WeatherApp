//
//  WeatherInfoViewController.swift
//  WeatherApp
//
//  Created on 28/03/22.
//  

import UIKit

class WeatherInfoViewController: UIViewController {
    @IBOutlet weak var summaryView: UIView!
    @IBOutlet weak var temperatureText: UILabel!
    @IBOutlet weak var weatherText: UILabel!
    @IBOutlet weak var lastCheckedDateTime: UILabel!
    @IBOutlet weak var weatherIcon: UIImageView!
    @IBOutlet weak var viewMoreButton: UIButton!
    
    lazy var viewModel: WeatherInfoVM = {
        return WeatherInfoVM()
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        debugPrint("currentCity ->", self.viewModel.currentCity as Any)
        initVM()
        setupUI()
    }
    
    func initVM() {
        viewModel.showError = { [weak self] title, msg in
            DispatchQueue.main.async {
                self?.showAlert(title: title, message: msg)
            }
        }
        
        viewModel.updateWeatherData = { [weak self] in
            DispatchQueue.main.async {
                self?.setupUI()
            }
        }
        
        if let locationKey = self.viewModel.currentCity?.key {
            self.viewModel.locationKey = locationKey
        } else if let key = self.viewModel.locationKey {
            self.viewModel.locationKey = key
        }
        self.viewModel.getWeatherInfo()    
    }
    
    func setupUI() {
        if let city = self.viewModel.currentCity {
            UserDefaultsManager.shared.addCityToUserDefaults(city: city)
        }
        
        var completeCityName = ""
        if let cityName = self.viewModel.currentCity?.localizedName {
            completeCityName += "\(cityName)"
        }
        if let stateName = self.viewModel.currentCity?.administrativeArea?.localizedName {
            completeCityName += ", \(stateName)"
        }
        if let countryName = self.viewModel.currentCity?.country?.localizedName {
            completeCityName += ", \(countryName)"
        }
        self.navigationItem.title = completeCityName
        temperatureText.text = "\(viewModel.currentWeatherData?.temperature?.metric?.value ?? 0) ºC"
        weatherText.text = viewModel.currentWeatherData?.weatherText
        
        if let epochTime = viewModel.currentWeatherData?.epochTime {
            lastCheckedDateTime.text = Double(epochTime).getDateStringFromUTC()
        }
        weatherIcon.image = UIImage(named: "\(viewModel.currentWeatherData?.weatherIcon ?? UIConstants.defaultWeatherIcon)")
    }
    
    @IBAction func viewMoreAction(_ sender: UIButton) {
        if let link = self.viewModel.currentWeatherData?.link, let url = URL(string: link) {
            UIApplication.shared.open(url)
        } else {
            self.showAlert(title: "Error", message: "No/bad link given")
        }
    }
}
