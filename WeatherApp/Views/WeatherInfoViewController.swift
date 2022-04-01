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
        initVM()
        setupUI()
        debugPrint("currentCity ->", self.viewModel.currentCity as Any)
        if let city = self.viewModel.currentCity {
            UserDefaultsManager.shared.addCityToUserDefaults(city: city)
        }
    }
    
    func initVM() {
        if let locationKey = self.viewModel.currentCity?.key {
            self.viewModel.locationKey = locationKey
        } else if let key = self.viewModel.locationKey {
            self.viewModel.locationKey = key
        }
        self.viewModel.getWeatherInfo()
        self.viewModel.currentWeatherData = WeatherInfoElement(localObservationDateTime: "2022-04-01T20:07:00+05:30", epochTime: 1648823820, weatherText: "Clear", weatherIcon: 33, hasPrecipitation: false, precipitationType: nil, isDayTime: false, temperature: Temperature(metric: Imperial(value: 32.8, unit: "C", unitType: 17), imperial: Imperial(value: 91, unit: "F", unitType: 18)), mobileLink: "http://www.accuweather.com/en/in/nagpur/204844/current-weather/204844?lang=en-us", link: "http://www.accuweather.com/en/in/nagpur/204844/current-weather/204844?lang=en-us")
    }
    
    func setupUI() {
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
        }
    }
}
