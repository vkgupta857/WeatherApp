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
    var currentWeatherData: WeatherInfoElement?
    
    func getWeatherInfo() {
        Services.getWeatherInfoService(self.locationKey ?? "") { result in
            switch result {
            case Result.success(let response):
                debugPrint(response)
            case Result.failure(let error):
                debugPrint(error.messageKey, error.message)
            }
        }
    }
}
