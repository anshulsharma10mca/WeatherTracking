//
//  ServiceResolver.swift
//  Weather Tracker
//
//  Created by Anshul Sharma on 12/23/24.
//

import Foundation

public enum EndPoint: String {
    case searchApi = "search", currentWeather = "current"
}

public struct WeatherServiceURLResolver {

    private var apiKey = "2e99b81ba28b4dbba0585914242312"
    private var baseURL =  URL(string: "https://api.weatherapi.com/v1/")

    public func generateImageURLRequest(from path: String) -> URLRequest? {
        var serverPath = path
        if path.range(of: "https://") == nil {
            serverPath = serverPath.replacingOccurrences(of: "//", with: "https://")
            serverPath = serverPath.replacingOccurrences(of: "64x64", with: "128x128")
        }
        
        guard let url = URL(string: serverPath)
        else {
            return nil
        }
        return URLRequest(url: url, cachePolicy: .reloadIgnoringCacheData)
    }

    public func generateURLRequest(from baseURL: URL, endPoint: EndPoint, queryParameters: [String: String]?) -> URLRequest? {
        var parameters: [String: String] = ["key": apiKey]
        if let queryParameters = queryParameters {
            parameters = parameters.appending(queryParameters)
        }

        guard var components = URLComponents(url: baseURL, resolvingAgainstBaseURL: true) else { return nil }
        components.path += endPoint.rawValue
        components.path += ".json"
        components.queryItems = parameters.map { URLQueryItem(name: $0.key, value: $0.value) }

        guard let url = components.url
        else {
            return nil
        }
        let urlRequest = URLRequest(url: url, cachePolicy: .reloadIgnoringCacheData)

        return urlRequest
    }

    func currentWeatherServiceURLRequest(with queryParameters: [String: String]? = nil) -> URLRequest? {
        guard let baseURL = baseURL else { return nil }
        return generateURLRequest(from: baseURL, endPoint: .currentWeather, queryParameters: queryParameters)
    }
    
    func searchLocationURL(with queryParameters: [String: String]? = nil) -> URLRequest? {
        guard let baseURL = baseURL else { return nil }
        return generateURLRequest(from: baseURL, endPoint: .searchApi, queryParameters: queryParameters)
    }
}
