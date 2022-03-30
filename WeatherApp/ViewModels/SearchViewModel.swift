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
    
    var recentCities: [SearchCity]?
    
    var updateSearchResults: (()->())?
    var showError: ((String)->())?
    
    func searchCities(_ searchText: String) {
        Services.searchCities(searchText) { [weak self] result in
            switch result {
            case Result.success(let response):
                self?.searchCityResults = response
            case Result.failure(let error):
                self?.showError?(error.message)
            }
        }
    }
    
    func getRecentCities() {
        if let cities = UserDefaultsManager.shared.getCitiesFromUserDefaults() {
            recentCities = cities
        }
    }
}
