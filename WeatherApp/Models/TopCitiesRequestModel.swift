//
//  TopCitiesRequestModel.swift
//  WeatherApp
//
//  Created on 30/03/22.
//  

import Foundation

class TopCities: BaseRequestModel {
    
    private var searchText: String?
    
    init(searchText: String) {
        self.searchText = searchText
    }
    
    override var path: String {
        return Endpoints.topCities.rawValue
    }
    
    override var parameters: [String : Any?] {
        return [
            "apikey": Constants.AccuWeatherApiKey
        ]
    }
}
