//
//  Services.swift
//  WeatherApp
//
//  Created on 30/03/22.
//  

import Foundation

class Services {
    class func searchCities(_ searchText: String, completion: @escaping(Swift.Result<SearchCities, ErrorModel>) -> Void) {
        ServiceManager.shared.sendRequest(request: SearchCitiesRequestModel(searchText: searchText)) { result in
            completion(result)
        }
    }
}
