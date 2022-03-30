//
//  SearchCitiesResponseModel.swift
//  WeatherApp
//
//  Created on 29/03/22.
//  

import Foundation

// MARK: - SearchCity
struct SearchCity: Codable {
    let version: Int?
    let key: String?
    let type: TypeEnum?
    let rank: Int?
    let localizedName: String?
    let country, administrativeArea: AdministrativeArea?

    enum CodingKeys: String, CodingKey {
        case version = "Version"
        case key = "Key"
        case type = "Type"
        case rank = "Rank"
        case localizedName = "LocalizedName"
        case country = "Country"
        case administrativeArea = "AdministrativeArea"
    }
}

// MARK: - AdministrativeArea
struct AdministrativeArea: Codable {
    let id, localizedName: String?

    enum CodingKeys: String, CodingKey {
        case id = "ID"
        case localizedName = "LocalizedName"
    }
}

enum TypeEnum: String, Codable {
    case city = "City"
}

typealias SearchCities = [SearchCity]
