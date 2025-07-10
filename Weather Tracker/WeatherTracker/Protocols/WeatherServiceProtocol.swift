//
//  WeatherServiceProtocol.swift
//  Weather Tracker
//
//  Created by Anshul Sharma on 12/23/24.
//

import UIKit

// Defines the protocol for the weather services
public protocol WeatherServiceProtocol {

    func searchLocation(query: String, completion: @escaping (Result<Array<City>, Error>) -> Void)

    func fetchWeatherInfoForLocation(query: String, completion: @escaping (Result<LocationWeatherInfo, Error>) -> Void)
    
    func fetchWeatherStatusIcon(for path: String, iconID: String, completion: @escaping (Result<UIImage, Error>) -> Void)
}
