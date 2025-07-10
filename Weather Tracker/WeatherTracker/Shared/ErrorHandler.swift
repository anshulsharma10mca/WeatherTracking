//
//  ErrorHandler.swift
//  Weather Tracker
//
//  Created by Anshul Sharma on 12/27/24.
//

public struct ErrorHandler {
    static func message(for error: ServiceError) -> String {
        switch error {
        case .errorCode(let code):
            switch code {
            case -1009:
                return Messages.noNetworkMessage
            default:
                return Messages.somethingWentWrong
            }
        case .emptyResponse:
            return Messages.invalidCityMessage
        case .apiError(_, _, _):
            return error.description
        default:
            return Messages.somethingWentWrong
        }
    }
}

extension ErrorHandler {
    enum Messages {
        static let invalidCityMessage = "Looks like searched city info is not correct."
        static let noNetworkMessage = "The Internet connection appears to be offline."
        static let somethingWentWrong = "Something went wrong, Please try to search again"
    }
}
