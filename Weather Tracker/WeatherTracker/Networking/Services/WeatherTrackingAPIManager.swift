//
//  WeatherTrackingManager.swift
//  Weather Tracker
//
//  Created by Anshul Sharma on 12/23/24.
//
import UIKit

public final class WeatherTrackingManager: WeatherServiceProtocol {

    private var serviceManager: Communicatable = ServiceManager()

    public func searchLocation(query: String, completion: @escaping (Result<Array<City>, Error>) -> Void) {
        let serviceURLResolver = WeatherServiceURLResolver()
        guard let serviceURLRequest = serviceURLResolver.searchLocationURL(with: ["q": query])
        else {
            completion(.failure(ServiceError.invalidEndPoint))
            return
        }

        serviceManager.get(serviceURLRequest, completion: completion)
    }

    public func fetchWeatherInfoForLocation(query: String, completion: @escaping (Result<LocationWeatherInfo, Error>) -> Void) {
        let serviceURLResolver = WeatherServiceURLResolver()
        guard let serviceURLRequest = serviceURLResolver.currentWeatherServiceURLRequest(with: ["q": query])
        else {
            completion(.failure(ServiceError.invalidEndPoint))
            return
        }

        serviceManager.get(serviceURLRequest, completion: completion)
    }
    
    public func fetchWeatherStatusIcon(for path: String, iconID: String, completion: @escaping (Result<UIImage, Error>) -> Void) {
        let serviceURLResolver = WeatherServiceURLResolver()
        guard let urlRequest = serviceURLResolver.generateImageURLRequest(from: path)
        else {
            completion(.failure(ServiceError.invalidServerPath))
            return
        }
        serviceManager.fetchImage(urlRequest, id: iconID, completion: completion)
    }
}
