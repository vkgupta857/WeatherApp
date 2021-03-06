//
//  Services.swift
//  WeatherApp
//
//  Created on 30/03/22.
//  

import Foundation

class Services {
    class func searchCitiesService(_ searchText: String, completion: @escaping(Swift.Result<SearchCities, ErrorModel>) -> Void) {
        ServiceManager.shared.sendRequest(request: SearchCitiesRequestModel(searchText: searchText)) { result in
            completion(result)
        }
    }
    
    class func getWeatherInfoService(_ locationKey: String, completion: @escaping(Swift.Result<WeatherInfo, ErrorModel>) -> Void) {
        ServiceManager.shared.sendRequest(request: WeatherInfoRequestModel(locationKey: locationKey)) { result in
            completion(result)
        }
    }
    
    class func getCityFromGeoLocationService(_ lat: Double, _ lng: Double, completion: @escaping(Swift.Result<CityFromGeoLocation, ErrorModel>) -> Void) {
        ServiceManager.shared.sendRequest(request: CityFromGeoLocationRequest(lat: lat, lng: lng)) { result in
            completion(result)
        }
    }
}
