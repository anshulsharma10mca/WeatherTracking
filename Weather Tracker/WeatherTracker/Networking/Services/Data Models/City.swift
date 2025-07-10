//
//  City.swift
//  Weather Tracker
//
//  Created by Anshul Sharma on 12/27/24.
//

public struct City: Codable, Identifiable, Hashable {
    public let id: Int
    public let name: String
    public let region: String
    public let country: String
    public let lat: Double
    public let lon: Double
    public let url: String
    
    public func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}
