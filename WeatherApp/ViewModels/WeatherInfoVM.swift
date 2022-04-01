//
//  WeatherInfoVM.swift
//  WeatherApp
//
//  Created on 29/03/22.
//  

import Foundation

class WeatherInfoVM {
    var locationKey: String?
    var currentCity: SearchCity?
    var currentWeatherData: WeatherInfoElement? {
        didSet {
            self.updateWeatherData?()
        }
    }
    var updateWeatherData: (()->())?
    var showError: ((String, String)->())?
    
    func getWeatherInfo() {
        Services.getWeatherInfoService(self.locationKey ?? "") { [weak self] result in
            switch result {
            case Result.success(let response):
                debugPrint(response)
                self?.currentWeatherData = response[0]
            case Result.failure(let error):
                debugPrint(error.messageKey, error.message)
                self?.showError?(error.messageKey, error.message)
            }
        }
    }
}
