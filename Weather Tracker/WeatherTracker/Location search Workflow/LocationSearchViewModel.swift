//
//  LocationSearchViewModel.swift
//  Weather Tracker
//
//  Created by Anshul Sharma on 12/23/24.
//
import Foundation
import SwiftUI
import Combine

// `LocationSearchViewModel` handles the business logic, network services etc.
public final class LocationSearchViewModel: ObservableObject {
    @Published var locationWeatherInfo: LocationWeatherInfo?
    @Published var weatherIcon: UIImage?
    @Published var error: ServiceError?

    @Published var locationList: Array<City>?

    @Published var selectedLocation: City?

    public var searchInProgress = false
    private let weatherService: WeatherServiceProtocol

    init(weatherService: WeatherServiceProtocol) {
        self.weatherService = weatherService
    }

    func handleError(_ error: ServiceError) {
        if case let .apiError(httpCode, _, _) = error, httpCode == 400 {
            self.error = ServiceError.emptyResponse
        } else {
            self.error = error
        }
    }

    func fetchWeatherInfoForLocation(query: String, completion: @escaping (Bool) -> Void) {
        weatherService.fetchWeatherInfoForLocation(query: query) { [weak self] result in
            self?.searchInProgress = false
            DispatchQueue.main.async {
                switch result {
                case .success(let locationWeatherInfo):
                    self?.locationWeatherInfo = locationWeatherInfo
                    self?.weatherService.fetchWeatherStatusIcon(for: locationWeatherInfo.weatherInfo.condition.icon, iconID: locationWeatherInfo.weatherInfo.id.uuidString) { iconFetchResult in
                        if let searchInProgress = self?.searchInProgress, searchInProgress {
                            self?.weatherIcon = nil
                            self?.locationWeatherInfo = nil
                            self?.error = nil
                            return
                        }
                        DispatchQueue.main.async {
                            switch iconFetchResult {
                            case .failure(_):
                                self?.weatherIcon = nil
                            case .success(let image):
                                self?.weatherIcon = image
                            }
                            completion(true)
                        }
                    }
                case .failure(let error as ServiceError):
                    self?.weatherIcon = nil
                    self?.locationWeatherInfo = nil
                    self?.handleError(error)
                    completion(false)
                case .failure(_):
                    self?.weatherIcon = nil
                    self?.locationWeatherInfo = nil
                    completion(false)
                }
            }
        }
    }

    func searchLocation(query: String) {
        guard !self.searchInProgress else { return }
        self.searchInProgress = true
        self.error = nil
        weatherService.searchLocation(query: query) { [weak self] result in
            self?.searchInProgress = false
            DispatchQueue.main.async {
                switch result {
                case .success(let locationArray):
                    self?.locationList = locationArray
                case .failure(let error as ServiceError):
                    self?.locationList = nil
                    self?.handleError(error)
                    
                case .failure(let error as NSError):
                    self?.handleError(ServiceError.errorCode(code: error.code))
                    self?.locationList = nil
                }
            }
        }
    }
}
