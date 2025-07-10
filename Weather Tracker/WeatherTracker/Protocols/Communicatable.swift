//
//  Communicatable.swift
//  Weather Tracker
//
//  Created by Anshul Sharma on 12/22/24.
//

import Foundation
import UIKit

public protocol Communicatable {

    func get<T: Decodable>(_ urlRequest: URLRequest, completion: @escaping (Result<T, Error>) -> ())

    func fetchImage(_ urlRequest: URLRequest, id: String, completion: @escaping(Result<UIImage, Error>) -> Void)
}
