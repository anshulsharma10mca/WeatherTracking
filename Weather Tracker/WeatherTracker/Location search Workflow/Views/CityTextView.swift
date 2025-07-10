//
//  CityTextView.swift
//  Weather Tracker
//
//  Created by Anshul Sharma on 12/24/24.
//

import SwiftUI

struct CityTextView: View {
    @ObservedObject var viewModel: LocationSearchViewModel

    @ViewBuilder
    var cityTextView: some View {
        Text("\(viewModel.locationWeatherInfo?.location.name ?? "")")
            .font(.custom(WeatherTrackerFont.bold.rawValue, size: Constants.cityTitleFontSize))
    }

    var body: some View {
        HStack {
            cityTextView
            getAirDirectionSymbol(for: viewModel.locationWeatherInfo?.weatherInfo.windDirection ?? "")
        }
        .frame(maxHeight: Constants.maxHeight)
    }

    private func getAirDirectionSymbol(for direction: String) -> Image? {
       switch direction {
            case "WSW": return Image("Vector-WSW", bundle: .main)
            case "WNW": return Image("Vector-WNW", bundle: .main)
            case "SSW": return Image("Vector-SSW", bundle: .main)
            case "SSE": return Image("Vector-SSE", bundle: .main)
            case "NNW": return Image("Vector-NNW", bundle: .main)
            case "NNE": return Image("Vector-NNE", bundle: .main)
            case "ESE": return Image("Vector-ESE", bundle: .main)
            case "ENE": return Image("Vector-ENE", bundle: .main)
            case "N": return Image("Vector-N", bundle: .main)
            case "S": return Image("Vector-S", bundle: .main)
            case "E": return Image("Vector-E", bundle: .main)
            case "W": return Image("Vector-W", bundle: .main)
            case "NE": return Image("Vector-NE", bundle: .main)
            case "NW": return Image("Vector-NW", bundle: .main)
            case "SE": return Image("Vector-SE", bundle: .main)
            case "SW": return Image("Vector-SW", bundle: .main)
            default: return nil
       }
    }
}

extension CityTextView {
    enum Constants {
        static let cityTitleFontSize: CGFloat = 30
        static let maxHeight: CGFloat = 40
    }
}

