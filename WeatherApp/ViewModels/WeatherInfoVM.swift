//
//  WeatherInfoVM.swift
//  WeatherApp
//
//  Created on 29/03/22.
//  

import Foundation

class WeatherInfoVM {
    var latitude: Double?
    var longitude: Double?
    var currentCity: SearchCity?
    
    func getWeatherInfo() {
        let locationKey = Int(currentCity?.key ?? "") ?? 0
        Services.getWeatherInfoService(locationKey) { result in
            switch result {
            case Result.success(let response):
                debugPrint(response)
            case Result.failure(let error):
                debugPrint(error.messageKey, error.message)
            }
        }
    }
}
