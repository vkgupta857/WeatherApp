//
//  Enums.swift
//  WeatherApp
//
//  Created on 28/03/22.
//  

import Foundation

enum SearchTableCellType: String {
    case recentSearch = "Recently Viewed"
    case topCities = "Top Cities"
    case suggestions = "Suggestions"
}

enum ErrorType: String {
    case general = "Error_general"
    case parsing = "Error_parsing"
}

enum Endpoints: String {
    case currentConditions = "currentconditions"
    case locations = "locations/v1/cities/autocomplete?"
    case topCities = "/locations/v1/topcities/50"
}
