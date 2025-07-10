//
//  WeatherInfoView.swift
//  Weather Tracker
//
//  Created by Anshul Sharma on 12/24/24.
//

import SwiftUI

public struct WeatherInfoView: View {
    @ObservedObject var viewModel: LocationSearchViewModel

    public var body: some View {
        Button {
            print("location selected")
        } label: {
            VStack(alignment: .center, spacing: Constants.verticalContentSpacing) {
                if let weatherIcon = viewModel.weatherIcon {
                    Image(uiImage: weatherIcon)
                        .resizable()
                        .frame(width: Constants.weatherIconWidth, height: Constants.weatherIconHeight)
                }
                CityTextView(viewModel: viewModel)
                if let temp = viewModel.locationWeatherInfo?.weatherInfo.tempC {
                    makeCurrentTempratureText(temp)
                }
                if let weatherInfo = viewModel.locationWeatherInfo?.weatherInfo {
                    AdditionalWeatherInfoView(weatherInfo: weatherInfo)
                        .background(Color(hex: "#F2F2F2"))
                        .cornerRadius(10)
                        .padding(Constants.additionalInfoPadding)
                }
            }
        }.tint(.black)
    }

    @ViewBuilder
    func makeCurrentTempratureText(_ temp: Double) -> some View {
        Text("\(Int(round(temp)))")
            .font(.custom(WeatherTrackerFont.medium.rawValue, size: 70)) +
        Text(" °")
            .baselineOffset(35)
            .font(.custom(WeatherTrackerFont.extraLight.rawValue, size: 30))
    }
}

public extension WeatherInfoView {
    enum Constants {
        static let verticalContentSpacing: CGFloat = 12
        static let weatherIconWidth: CGFloat = 128
        static let weatherIconHeight: CGFloat = 128
        static let additionalInfoPadding = EdgeInsets(top: 8, leading: 58, bottom: 8, trailing: 58)
    }
}
