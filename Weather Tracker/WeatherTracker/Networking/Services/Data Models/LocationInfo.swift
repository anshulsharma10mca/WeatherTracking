//
//  Location.swift
//  Weather Tracker
//
//  Created by Anshul Sharma on 12/23/24.
//
import Foundation

// Contains LocationInfo Information like name, region, country, lattitude, longitude
public struct LocationInfo: Identifiable, Codable, Hashable {
    public var id = UUID()
    public let name: String
    public let region: String
    public let country: String
    public let lat: Double
    public let lon: Double
}
