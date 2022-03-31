//
//  Extensions.swift
//  WeatherApp
//
//  Created on 28/03/22.
//  

import UIKit

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

extension UIViewController {
    func showAlert(title: String, message: String, defaultAction: (()->())? = nil) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: { action in
            defaultAction?()
        }))
        self.present(alertController, animated: true, completion: nil)
    }
}
