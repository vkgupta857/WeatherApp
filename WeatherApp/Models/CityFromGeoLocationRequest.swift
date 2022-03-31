//
//  CityFromGeoLocationRequest.swift
//  WeatherApp
//
//  Created on 31/03/22.
//  

import Foundation

class CityFromGeoLocationRequest: BaseRequestModel {
    
    private var lat: Double
    private var lng: Double
    
    init(lat: Double, lng: Double) {
        self.lat = lat
        self.lng = lng
    }
    
    override var path: String {
        return Endpoints.cityFromGeoLocation.rawValue
    }
    
    override var parameters: [String : Any?] {
        return [
            "apikey": Constants.AccuWeatherApiKey,
            "q": "\(lat),\(lng)"
        ]
    }
}
