//
//  CityWeather.swift
//  Weather Tracker
//
//  Created by Anshul Sharma on 12/23/24.
//å

import Foundation
import SwiftUI

public struct LocationWeatherInfo: Identifiable, Hashable, Codable {
    public var id = UUID()
    public enum CodingKeys: String, CodingKey {
        case location
        case weatherInfo = "current"
    }

    public var location: LocationInfo
    public var weatherInfo: WeatherInfo
}
