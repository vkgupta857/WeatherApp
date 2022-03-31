//
//  CityFromGeoLocationResponse.swift
//  WeatherApp
//
//  Created on 31/03/22.
//  

import Foundation

// MARK: - CityFromGeoLocation
struct CityFromGeoLocation: Codable {
    let version: Int?
    let key, type: String?
    let rank: Int?
    let localizedName, englishName, primaryPostalCode: String?
    let region, country: Country?
    let administrativeArea: AdministrativeArea?
    let timeZone: TimeZone?
    let geoPosition: GeoPosition?
    let isAlias: Bool?
    let supplementalAdminAreas: [SupplementalAdminArea]?
    let dataSets: [String]?

    enum CodingKeys: String, CodingKey {
        case version = "Version"
        case key = "Key"
        case type = "Type"
        case rank = "Rank"
        case localizedName = "LocalizedName"
        case englishName = "EnglishName"
        case primaryPostalCode = "PrimaryPostalCode"
        case region = "Region"
        case country = "Country"
        case administrativeArea = "AdministrativeArea"
        case timeZone = "TimeZone"
        case geoPosition = "GeoPosition"
        case isAlias = "IsAlias"
        case supplementalAdminAreas = "SupplementalAdminAreas"
        case dataSets = "DataSets"
    }
}

// MARK: - Country
struct Country: Codable {
    let id, localizedName, englishName: String?

    enum CodingKeys: String, CodingKey {
        case id = "ID"
        case localizedName = "LocalizedName"
        case englishName = "EnglishName"
    }
}

// MARK: - GeoPosition
struct GeoPosition: Codable {
    let latitude, longitude: Double?
    let elevation: Elevation?

    enum CodingKeys: String, CodingKey {
        case latitude = "Latitude"
        case longitude = "Longitude"
        case elevation = "Elevation"
    }
}

// MARK: - Elevation
struct Elevation: Codable {
    let metric, imperial: Imperial?

    enum CodingKeys: String, CodingKey {
        case metric = "Metric"
        case imperial = "Imperial"
    }
}

// MARK: - SupplementalAdminArea
struct SupplementalAdminArea: Codable {
    let level: Int?
    let localizedName, englishName: String?

    enum CodingKeys: String, CodingKey {
        case level = "Level"
        case localizedName = "LocalizedName"
        case englishName = "EnglishName"
    }
}

// MARK: - TimeZone
struct TimeZone: Codable {
    let code, name: String?
    let gmtOffset: Double?
    let isDaylightSaving: Bool?
    let nextOffsetChange: JSONNull?

    enum CodingKeys: String, CodingKey {
        case code = "Code"
        case name = "Name"
        case gmtOffset = "GmtOffset"
        case isDaylightSaving = "IsDaylightSaving"
        case nextOffsetChange = "NextOffsetChange"
    }
}
