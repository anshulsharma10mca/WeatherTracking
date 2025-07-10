//
//  ServiceError.swift
//  Weather Tracker
//
//  Created by Anshul Sharma on 12/27/24.
//

import Foundation

enum ServiceError: Error, CustomStringConvertible, Equatable {
    case unknown
    case emptyResponse
    case invalidEndPoint
    case invalidServerPath
    case invalidResponse
    case invalidJSON
    case errorCode(code: Int)
    case apiError(httpCode: Int, code: Int, message: String)
    
    var description: String {
        switch self {
        case .unknown:
            return "Error: \(errorCode). Unknown error occured."
        case .emptyResponse:
            return "Error: \(errorCode). Couldn't find result for your search."
        case .invalidResponse, .invalidEndPoint, .invalidServerPath:
            return "Error: \(errorCode). Can't reach to remote server, please contact developers."
        case .apiError(let httpCode, let code, _):
            switch httpCode {
                // code below means
                // 1002 "Parameter 'q' not provided."
                // 1003 "API key not provided."
                // 403 "API key has exceeded calls per month quota."
            case 400, 401, 403:
                return "Error: \(code). Can't reach to remote server. If problem persists then please contact developers."
            default:
                return "Unknown error code \(errorCode). If problem persists then please contact developers."
            }
        default:
            return "Unknown error. If problem persists then please contact developers."
        }
    }
    
    var errorCode: String {
        switch self {
        case .unknown:
            return "E-111"
        case .invalidResponse:
            return "E-112"
        case .invalidEndPoint:
            return "E-113"
        case .invalidServerPath:
            return "E-114"
        case .emptyResponse:
            return "E-115"
        case .invalidJSON:
            return "E-116"
        case .errorCode(let code):
            return "\(code)"
        case .apiError(_, let code, _):
            return "\(code)"
        }
    }
    
    static func == (lhs: ServiceError, rhs: ServiceError) -> Bool {
            switch (lhs, rhs) {
            case (.unknown, .unknown), (.invalidResponse, .invalidResponse), (.invalidEndPoint, .invalidEndPoint), (.invalidServerPath, .invalidServerPath), (.emptyResponse, .emptyResponse), (.invalidJSON, .invalidJSON):
                return true
            case let (.apiError(lhsErrorValue, _, _), .apiError(rhsErrorValue, _, _)):
                return lhsErrorValue == rhsErrorValue
            default:
                return false
            }
        }
}
