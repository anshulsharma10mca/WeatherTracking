//
//  OtherWeatherInfoView.swift
//  Weather Tracker
//
//  Created by Anshul Sharma on 12/24/24.
//
import SwiftUI

public struct AdditionalWeatherInfoView: View {
    public var weatherInfo: WeatherInfo

    @ViewBuilder
    func makeFeelsLikeTempratureText(_ temp: Double) -> some View {
        Text("\(Int(round(temp)))").font(.custom(WeatherTrackerFont.medium.rawValue, size: 15)) +
        Text(" °").font(.custom(WeatherTrackerFont.medium.rawValue, size: 15))
    }

    @ViewBuilder
    func makeColumnView(title: String, detail: String) -> some View {
        VStack {
            Text(title)
                .font(.custom(WeatherTrackerFont.medium.rawValue, size: 12))
                .foregroundStyle(Color(hex: "#C2C2C2"))
            Text(detail)
                .font(.custom(WeatherTrackerFont.medium.rawValue, size: 15))
                .foregroundStyle(Color(hex: "#9A9A9A"))
        }
    }

    @ViewBuilder
    func makeFeelsLikeTempColumnView(title: String, temp: Double) -> some View {
        VStack {
            Text(title)
                .font(.custom(WeatherTrackerFont.medium.rawValue, size: 12))
                .foregroundStyle(Color(hex: "#C2C2C2"))
            makeFeelsLikeTempratureText(weatherInfo.feelslikeC)
                .font(.custom(WeatherTrackerFont.medium.rawValue, size: 15))
                .foregroundStyle(Color(hex: "#9A9A9A"))
        }
    }

    public var body: some View {
        HStack {
            makeColumnView(title: "Humidity", detail: "\(weatherInfo.humidity)%")
            .padding(EdgeInsets(top: 16, leading: 16, bottom: 16, trailing: 8))
            Spacer()
            makeColumnView(title: "UV", detail: "\(Int(round(weatherInfo.uv)))")
            .padding(EdgeInsets(top: 16, leading: 8, bottom: 16, trailing: 8))
            Spacer()
            makeFeelsLikeTempColumnView(title: "Feels Like", temp: weatherInfo.feelslikeC)
            .padding(EdgeInsets(top: 16, leading: 8, bottom: 16, trailing: 16))
        }
        .frame(maxHeight: 75)
    }
}
