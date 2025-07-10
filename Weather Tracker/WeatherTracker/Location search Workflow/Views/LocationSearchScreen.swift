//
//  LocationSearchScreen.swift
//  Weather Tracker
//
//  Created by Anshul Sharma on 12/23/24.
//
import Foundation
import SwiftUI

struct LocationSearchScreen: View {

    @AppStorage("savedLocations") private var savedLocationsData: Data?
    @ObservedObject private var viewModel: LocationSearchViewModel
    
    @State private var savedLocations: [LocationWeatherInfo] = []
    @State private var searchText = ""
    @State private var isSearching = false
    @State private var shouldTriggerSearch = false
    @State private var selectedCity: Int?

    public init(weatherService: WeatherServiceProtocol) {
        self.viewModel = LocationSearchViewModel(weatherService: weatherService)
    }

    var body: some View {
        NavigationView {
            VStack {
                SearchBar(text: $searchText, isSearching: $isSearching, shouldTriggerSearch: $shouldTriggerSearch)
                    .onChange(of: shouldTriggerSearch) { newValue in
                        guard shouldTriggerSearch else { return }
                        if searchText.isEmpty {
                            viewModel.error = nil
                            viewModel.locationList = nil // Clear results on empty search
                            viewModel.locationWeatherInfo = nil
                            viewModel.selectedLocation = nil
                            selectedCity = nil
                        } else {
                            viewModel.locationWeatherInfo = nil
                            viewModel.selectedLocation = nil
                            viewModel.locationList = nil
                            selectedCity = nil
                            viewModel.searchLocation(query: searchText)
                        }
                    }
                    .onChange(of: searchText) { oldValue, newValue in
                        if newValue.isEmpty {
                            viewModel.error = nil
                            viewModel.locationList = nil // Clear results on empty search
                            viewModel.locationWeatherInfo = nil
                            viewModel.selectedLocation = nil
                            selectedCity = nil
                        }
                    }
                if let _ = viewModel.locationWeatherInfo, !searchText.isEmpty {
                    WeatherInfoView(viewModel: viewModel)
                } else {
                    LocationListView(viewModel: viewModel, selectedItem: $selectedCity)
                }
                Spacer()
            }
            .onAppear {
                loadSavedLocations()
            }
            .overlay {
                if viewModel.error != nil || (viewModel.locationList == [] && !searchText.isEmpty) {
                    ContentUnavailableView {
                        let serviceError = serviceError(from: viewModel.error)
                        Text(ErrorHandler.message(for: serviceError))
                            .foregroundStyle(color(error:serviceError))
                            .font(.custom(WeatherTrackerFont.semiBold.rawValue, size: 30))
                    }
                } else if searchText.isEmpty {
                    /// In case there aren't any search results, we can
                    /// show the content unavailable view.
                    ContentUnavailableView {
                        Text(Constants.noCitySelectedMessage)
                            .foregroundStyle(Color.black)
                            .font(.custom(WeatherTrackerFont.semiBold.rawValue, size: 30))
                    } description: {
                        Text(Constants.searchCityMessage)
                            .foregroundStyle(Color.black)
                            .font(.custom(WeatherTrackerFont.semiBold.rawValue, size: 15))
                    }
                }
            }
        }
    }
    
    private func findLocationInLocalStore(query: String) -> [LocationWeatherInfo]? {
        let weatherInfoList: [LocationWeatherInfo]? = savedLocations.filter { $0.location.name.contains(query) }
        return weatherInfoList
    }

    private func loadSavedLocations() {
        if let data = savedLocationsData, let decodedLocations = try? JSONDecoder().decode([LocationWeatherInfo].self, from: data) {
            savedLocations = decodedLocations
        }
    }

    private func serviceError(from error: ServiceError?) -> ServiceError {
        var error: ServiceError = .emptyResponse
        if let serviceError = viewModel.error {
            error = serviceError
        }
        return error
    }

    private func color(error: ServiceError?) -> Color {
        switch error {
        case .emptyResponse:
            return .blue
        default:
            return .red
        }
    }

    private func selectCityFor(id: Int) {
        viewModel.selectedLocation = viewModel.locationList?.first (where: { $0.id == id })
    }
}

extension LocationSearchScreen {
    enum Constants {
        static let noCitySelectedMessage = "No city selected"
        static let searchCityMessage = "Please search a city"
    }
}
