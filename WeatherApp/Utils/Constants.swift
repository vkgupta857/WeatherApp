//
//  Constants.swift
//  WeatherApp
//
//  Created on 28/03/22.
//  

import Foundation

struct Constants {
    static let kLat = "lat"
    static let kLong = "long"
    
    static let AccuWeatherApiKeyIdentifier = "AccuWeather_ApiKey"
    static var AccuWeatherApiKey: String {
        get {
            guard let apiKey = Bundle.main.infoDictionary?[AccuWeatherApiKeyIdentifier] as? String else { return "" }
            return apiKey
        }
    }
    
    // default lat,lang for nagpur city
    static let defaultCityName = "Nagpur"
    static let defaultLatitude = 21.1458
    static let defaultLongitude = 79.0882
    
    static let searchCitiesOffset = 5
}

struct UIConstants {
    // Cell image for search table view cell
    static let recentSearchImage = "clock.arrow.circlepath"
    static let topCitiesImage = "arrow.up.forward.app"
    static let searchedCitiesImageName = "location"
    static let currentLocationImageName = "safari"
    static let defaultWeatherIcon = 1
    
    // Storyboard/ViewController names
    static let mainStoryboard = "Main"
    static let weatherInfoVC = "WeatherInfoViewController"
}

struct StringConstants {
    static let recentSearchText = "Recently Viewed"
    static let topCitiesText = "Top Searches"
    static let searchBarPlaceHolder = "Search cities..."
    static let currentLocationText = "My Location"
}
