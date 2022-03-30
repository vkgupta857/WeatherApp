//
//  SearchViewModel.swift
//  WeatherApp
//
//  Created on 29/03/22.
//  

import Foundation

class SearchViewModel {
    
    var searchCityResults: [SearchCity]? {
        didSet {
            updateSearchResults?()
        }
    }
    
    var updateSearchResults: (()->())?
    
    func searchCities(_ searchText: String) {
        Services.searchCities(searchText) { result in
            switch result {
            case Result.success(let response):
                // Handle successfull response
                debugPrint(response)
                break
            case Result.failure(let error):
                // Handle error
                debugPrint(error.messageKey, error.message)
                break
            }
        }
    }
}
