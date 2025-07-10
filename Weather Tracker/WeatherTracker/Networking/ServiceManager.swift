//
//  ServiceManager.swift
//  DataParsingAndDisplay
//
//  Created by Anshul Sharma on 11/23/24.
//

import Foundation
import UIKit
import SwiftUICore


public final class ServiceManager: Communicatable {
    
    static var imageCache = ImageCache()
    private var dataTask: URLSessionDataTask?

    private func parseErrorResponse(httpCode: Int, data: Data?, completion: (ServiceError) -> Void) {
        guard let data = data
        else {
            completion(.unknown)
            return
        }
        if let errorResponse = try? JSONDecoder().decode(ApiError.self, from: data) {
            completion(.apiError(httpCode: httpCode, code: errorResponse.code, message: errorResponse.message))
        } else {
            completion(.unknown)
        }
    }

    public func get<T: Decodable>(_ urlRequest: URLRequest, completion: @escaping (Result<T, Error>) -> ()) {
        dataTask?.cancel()
    
        dataTask = URLSession.shared.dataTask(with: urlRequest) { [weak self] data, response, error in
            guard error == nil
            else {
                completion(.failure(error ?? ServiceError.unknown))
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse
            else {
                completion(.failure(ServiceError.invalidResponse))
                return
            }
            
            guard (200...299).contains(httpResponse.statusCode)
            else {
                self?.parseErrorResponse(httpCode: httpResponse.statusCode, data: data) { serviceError in
                    completion(.failure(serviceError))
                }
                return
            }
            if let data = data {
                do {
                    
                    //TODO: remove debug code - START
                    guard let string = String(data: data, encoding: .utf8)
                    else {
                        completion(.failure(NSError(domain: "Could not convert data to string", code: -1, userInfo: nil)))
                        return
                    }
                    print("response string: \(string)")
                    
                    //TODO: remove debug code - END

                    let responseData = try JSONDecoder().decode(T.self, from: data)
                    completion(.success(responseData))
                } catch {
                    completion(.failure(error))
                }
            }
        }
        dataTask?.resume()
    }

    public func fetchImage(_ urlRequest: URLRequest, id: String, completion: @escaping(Result<UIImage, Error>) -> Void) {
        if let image = ServiceManager.imageCache[id] {
            completion(.success(image))
        } else {
            let imageFetchTask = URLSession.shared.dataTask(with: urlRequest) { imageData, response, error in
                if let data = imageData {
                    if let newImage = UIImage(data: data) {
                        ServiceManager.imageCache[id] = newImage
                        completion(.success(newImage))
                    } else if let error = error {
                        completion(.failure(error))
                    } else {
                        completion(.failure(ServiceError.unknown))
                    }
                } else if let error = error {
                    completion(.failure(error))
                } else {
                    completion(.failure(ServiceError.unknown))
                }
            }
            imageFetchTask.resume()
        }
    }
}
