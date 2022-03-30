//
//  SearchCitiesRequestModel.swift
//  WeatherApp
//
//  Created on 29/03/22.
//  

import Foundation

class SearchCitiesRequestModel: BaseRequestModel {
    
    private var searchText: String?
    
    init(searchText: String) {
        self.searchText = searchText
    }
    
    override var path: String {
        return Endpoints.locations.rawValue
    }
    
    override var parameters: [String : Any?] {
        return [
            "apikey": Constants.AccuWeatherApiKey,
            "offset": Constants.searchCitiesOffset,
            "q": searchText,
        ]
    }
}
