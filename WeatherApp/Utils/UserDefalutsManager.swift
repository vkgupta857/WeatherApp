//
//  UserDefalutsManager.swift
//  WeatherApp
//
//  Created on 30/03/22.
//  

import Foundation

class UserDefaultsManager {
    private let userDefaults = UserDefaults.standard
    private var cityArray: [SearchCity]
    private let key = "cities"
    
    public static let shared = UserDefaultsManager()
    
    private init() {
        do {
            if let citiesData = UserDefaults.standard.data(forKey: key), let cities = try JSONDecoder().decode([SearchCity]?.self, from: citiesData), cities.count > 0 {
                cityArray = cities
            } else {
                cityArray = []
            }
        } catch (let error) {
            debugPrint(error)
            cityArray = []
        }
    }
    
    func addCityToUserDefaults(city: SearchCity){
        cityArray.append(city)
        do {
            let citiesData = try JSONEncoder().encode(cityArray)
            userDefaults.setValue(citiesData, forKey: key)
        } catch (let error) {
            debugPrint(error)
        }
    }
    
    func getCitiesFromUserDefaults() -> [SearchCity]? {
        do {
            if let citiesData = UserDefaults.standard.data(forKey: key), let cityArray = try JSONDecoder().decode([SearchCity]?.self, from: citiesData), cityArray.count > 0 {
                return cityArray
            }
        } catch (let error) {
            debugPrint(error)
        }
        return nil
    }
}
