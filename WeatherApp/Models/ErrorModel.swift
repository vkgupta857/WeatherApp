//
//  ErrorModel.swift
//  WeatherApp
//
//  Created on 29/03/22.
//  

import Foundation

enum ErrorKey: String {
    case general = "Error_general"
    case parsing = "Error_parsing"
    case serviceUnavailable = "Error_serviceUnavailable"
}

class ErrorModel: Error {
    
    // MARK: - Properties
    var messageKey: String
    var message: String
    
    init(_ messageKey: String, message: String = "") {
        self.messageKey = messageKey
        self.message = message
    }
    
    class func generalError() -> ErrorModel {
        return ErrorModel(ErrorKey.general.rawValue)
    }
}
