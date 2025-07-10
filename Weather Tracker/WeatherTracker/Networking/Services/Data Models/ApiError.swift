//
//  ApiError.swift
//  Weather Tracker
//
//  Created by Anshul Sharma on 12/27/24.
//

import Foundation

struct ApiError: Decodable, Identifiable {
    
    enum CodingKeys: String, CodingKey {
        case code
        case message
    }
    let id = UUID()
    let code: Int
    let message: String
}
