//
//  WeatherInfoResponseModel.swift
//  WeatherApp
//
//  Created on 30/03/22.
//  

import Foundation

// MARK: - WeatherInfoElement
struct WeatherInfoElement: Codable {
    let localObservationDateTime: String?
    let epochTime: Int?
    let weatherText: String?
    let weatherIcon: Int?
    let hasPrecipitation: Bool?
    let precipitationType: JSONNull?
    let isDayTime: Bool?
    let temperature: Temperature?
    let mobileLink, link: String?

    enum CodingKeys: String, CodingKey {
        case localObservationDateTime = "LocalObservationDateTime"
        case epochTime = "EpochTime"
        case weatherText = "WeatherText"
        case weatherIcon = "WeatherIcon"
        case hasPrecipitation = "HasPrecipitation"
        case precipitationType = "PrecipitationType"
        case isDayTime = "IsDayTime"
        case temperature = "Temperature"
        case mobileLink = "MobileLink"
        case link = "Link"
    }
}

// MARK: - Temperature
struct Temperature: Codable {
    let metric, imperial: Imperial?

    enum CodingKeys: String, CodingKey {
        case metric = "Metric"
        case imperial = "Imperial"
    }
}

// MARK: - Imperial
struct Imperial: Codable {
    let value: Double?
    let unit: String?
    let unitType: Int?

    enum CodingKeys: String, CodingKey {
        case value = "Value"
        case unit = "Unit"
        case unitType = "UnitType"
    }
}

typealias WeatherInfo = [WeatherInfoElement]

// MARK: - Encode/decode helpers

class JSONNull: Codable, Hashable {

    public static func == (lhs: JSONNull, rhs: JSONNull) -> Bool {
        return true
    }

    public var hashValue: Int {
        return 0
    }

    public func hash(into hasher: inout Hasher) {
        // No-op
    }

    public init() {}

    public required init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if !container.decodeNil() {
            throw DecodingError.typeMismatch(JSONNull.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for JSONNull"))
        }
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        try container.encodeNil()
    }
}
