//
//  WeatherInfoRequestModel.swift
//  WeatherApp
//
//  Created on 30/03/22.
//

import Foundation

class WeatherInfoRequestModel: BaseRequestModel {
    
    private var locationKey: Int
    
    init(locationKey: Int) {
        self.locationKey = locationKey
    }
    
    override var path: String {
        return Endpoints.currentConditions.rawValue.appending("\(locationKey)")
    }
    
    override var parameters: [String : Any?] {
        return [
            "apikey": Constants.AccuWeatherApiKey
        ]
    }
}
