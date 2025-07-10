//
//  WeatherInfo.swift
//  Weather Tracker
//
//  Created by Anshul Sharma on 12/23/24.
//

import Foundation

public struct WeatherInfo: Identifiable, Codable, Hashable {
    
    public enum CodingKeys: String, CodingKey {
        case tempC = "temp_c"
        case tempF = "temp_f"
        case condition
        case humidity
        case cloud
        case windDirection = "wind_dir"
        case feelslikeC = "feelslike_c"
        case feelslikeF = "feelslike_f"
        case uv
    }
    public var id = UUID()
    public let tempC: Double
    public let tempF: Double
    public let condition: Condition
    public let windDirection: String
    public let humidity: Int
    public let cloud: Int
    public let feelslikeC: Double
    public let feelslikeF: Double
    public let uv: Double

    public struct Condition: Codable, Hashable {
        public let text: String
        public let icon: String
        public let code: Int
    }
}
