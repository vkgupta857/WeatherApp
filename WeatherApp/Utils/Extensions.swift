//
//  Extensions.swift
//  WeatherApp
//
//  Created on 28/03/22.
//  

import UIKit

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

extension Double {
    func getDateStringFromUTC() -> String {
        let date = Date(timeIntervalSince1970: self)
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "en_IN")
        dateFormatter.dateStyle = .medium
        dateFormatter.dateFormat = "dd MMMM YYYY, hh:mm a"
        return dateFormatter.string(from: date)
    }
}
