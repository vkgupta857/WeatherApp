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
    case serviceUnavailable = "Service Unavailable!"
}

enum Endpoints: String {
    case currentConditions = "/currentconditions/v1/"
    case locations = "/locations/v1/cities/autocomplete?"
    case cityFromGeoLocation = "/locations/v1/cities/geoposition/search"
}

enum ErrorTitle: String {
    case generalError = "Error!"
    case currentLocationError = "Cannot detect location!"
    case serviceUnavailable = "Service Unavailable"
}

enum ErrorMessage: String {
    case badLink = "No/bad link given"
    case currentLocation = "Using default location of Nagpur, Maharashtra, India"
    case search = "Please enter 3 or more characters"
    case invalidCity = "Invalid city selected"
}
