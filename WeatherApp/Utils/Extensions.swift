//
//  Extensions.swift
//  WeatherApp
//
//  Created on 28/03/22.
//  

import Foundation

extension Date {
    func getDateString(from epochTime: Double) -> String {
        let date = Date(timeIntervalSince1970: epochTime)
        let dateFormatter = DateFormatter()
        dateFormatter.timeStyle = DateFormatter.Style.medium //Set time style
        dateFormatter.dateStyle = DateFormatter.Style.medium //Set date style
        dateFormatter.timeZone = .current
        return dateFormatter.string(from: date)
    }
}

extension String {
    func localized() -> String {
        return NSLocalizedString(self, comment: self)
    }
}
