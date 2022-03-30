//
//  UserDefalutsManager.swift
//  WeatherApp
//
//  Created on 30/03/22.
//  

import Foundation

class UserDefaultsManager {
    private let userDefaults = UserDefaults.standard
    private var cityArray: [SearchCity] = []
    private let key = "cities"
    
    public static let shared = UserDefaultsManager()
    
    func addCityToUserDefaults(city: SearchCity){
        cityArray.append(city)
        userDefaults.setValue(cityArray, forKey: key)
    }
    
    func getCitiesFromUserDefaults() -> [SearchCity]? {
        if let cities = userDefaults.value(forKey: key) as? [SearchCity] {
            return cities
        }
        return nil
    }
}
