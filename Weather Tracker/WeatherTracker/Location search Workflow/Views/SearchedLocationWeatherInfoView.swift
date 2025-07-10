//
//  SavedLocationWeatherInfoView.swift
//  Weather Tracker
//
//  Created by Anshul Sharma on 12/28/24.
//

import SwiftUI

public struct SearchedLocationWeatherInfoView: View {
    @State public var locationWeatherInfo: LocationWeatherInfo?

    public var body: some View {
        if let locationWeatherInfo = locationWeatherInfo {
            HStack {
                VStack {
                    Text("\(locationWeatherInfo.location.name)")
                        .font(.custom(WeatherTrackerFont.semiBold.rawValue, size: 20))
                    makeCurrentTempratureText(locationWeatherInfo.weatherInfo.feelslikeC)
                }
            }
            Spacer()
            if let weatherIcon = weatherIcon {
                Image(uiImage: weatherIcon)
                    .resizable()
                    .frame(width: Constants.weatherIconWidth, height: Constants.weatherIconHeight)
            }
        } else {
            EmptyView()
        }
    }

    @ViewBuilder
    func makeCurrentTempratureText(_ temp: Double) -> some View {
        Text("\(Int(round(temp)))")
            .font(.custom(WeatherTrackerFont.medium.rawValue, size: 60)) +
        Text(" °")
            .baselineOffset(30)
            .font(.custom(WeatherTrackerFont.extraLight.rawValue, size: 20))
    }
}

extension SearchedLocationWeatherInfoView {
    enum Constants {
        static let weatherIconWidth: Double = 83
        static let weatherIconHeight: Double = 83
    }
}
