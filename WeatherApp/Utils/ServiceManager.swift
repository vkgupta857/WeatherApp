//
//  ServiceManager.swift
//  WeatherApp
//
//  Created on 29/03/22.
//  

import Foundation

class ServiceManager {
    
    // MARK: - Properties
    static let shared: ServiceManager = ServiceManager()
    
    var baseURL: String = "http://dataservice.accuweather.com"
}

// MARK: - Public Functions
extension ServiceManager {
    
    func sendRequest<T: Codable>(request: BaseRequestModel, completion: @escaping(Swift.Result<T, ErrorModel>) -> Void) {

        URLSession.shared.dataTask(with: request.urlRequest()) { data, response, error in
            guard let httpResponse = response as? HTTPURLResponse else {
                let error = ErrorModel(ErrorKey.general.rawValue)
                completion(Result.failure(error))
                return
            }
            switch httpResponse.statusCode {
            case 200:
                do {
                    guard let data = data, let parsedResponse = try JSONDecoder().decode(T?.self, from: data) else {
                        let error: ErrorModel = ErrorModel(ErrorKey.parsing.rawValue)
                        completion(Result.failure(error))
                        return
                    }
                    completion(Result.success(parsedResponse))
                } catch (let error){
                    debugPrint(error)
                }
            case 503:
                guard let data = data, let parsedResponse = try? JSONDecoder().decode(ErrorResponseModel.self, from: data) else {
                    let error: ErrorModel = ErrorModel(ErrorKey.parsing.rawValue)
                    completion(Result.failure(error))
                    return
                }
                let error = ErrorModel(ErrorKey.serviceUnavailable.rawValue, message: parsedResponse.message ?? "")
                completion(Result.failure(error))
            case 401:
                let error = ErrorModel(ErrorKey.general.rawValue, message: "401")
                completion(Result.failure(error))
            default:
                let error = ErrorModel(ErrorKey.general.rawValue)
                completion(Result.failure(error))
            }
        }.resume()
    }
}
