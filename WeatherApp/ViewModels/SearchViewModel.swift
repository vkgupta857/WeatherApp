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
    var latitude: Double?
    var longitude: Double?
    
    var updateSearchResults: (()->())?
    var showError: ((String)->())?
    var showCurrentCityWeather: ((CityFromGeoLocation)->())?
    
    func searchCities(_ searchText: String) {
        Services.searchCitiesService(searchText) { [weak self] result in
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
            recentCities = cities.reversed()
        }
    }
    
    func getCityFromGeoLocation() {
        if let lat = latitude, let lng = longitude {
            Services.getCityFromGeoLocationService(lat, lng) { [weak self] result in
                switch result {
                case Result.success(let response):
                    debugPrint(response)
                    self?.showCurrentCityWeather?(response)
                case Result.failure(let error):
                    self?.showError?(error.message)
                }
            }
        }
    }
}
