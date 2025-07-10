//
//  WeatherTrackerFont.swift
//  Weather Tracker
//
//  Created by Anshul Sharma on 12/24/24.
//

enum WeatherTrackerFont: String, CustomStringConvertible {
    case medium = "Poppins-Medium"
    case bold = "Poppins-Bold"
    case regular = "Poppins-Regular"
    case extraLight = "Poppins-ExtraLight"
    case thin = ""
    case semiBold = "Poppins-SemiBold"
    
    var description: String {
        rawValue
    }
}
