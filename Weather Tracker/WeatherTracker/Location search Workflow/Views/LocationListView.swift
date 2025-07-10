//
//  LocationListView.swift
//  Weather Tracker
//
//  Created by Anshul Sharma on 12/27/24.
//

import SwiftUI

public struct LocationListView: View {

    @ObservedObject public var viewModel: LocationSearchViewModel
    @Binding var selectedItem: Int?
    @State private var isLoading = false

    public init(viewModel: LocationSearchViewModel, selectedItem: Binding<Int?>) {
        self.viewModel = viewModel
        self._selectedItem = selectedItem
    }

    public var body: some View {
        if let locationList = viewModel.locationList {
            NavigationView {
                Group {
                    if isLoading {
                        ProgressView()
                            .frame(maxWidth: .infinity, maxHeight: .infinity)
                    } else {
                        List(selection: $selectedItem) {
                            ForEach(locationList) { location in
                                Text("\(location.name), \(location.region), \(location.country)")
                                    .lineLimit(3)
                                    .multilineTextAlignment(.leading)
                            }
                        }
                    }
                }
                .onChange(of: selectedItem) { id in
                    guard let selectedLocation = viewModel.locationList?.first (where: { $0.id == id }) else { return }
                    viewModel.selectedLocation = selectedLocation
                    print("selectedLocation: \(viewModel.selectedLocation?.name ?? "UNKNOW")")
                    
                    Task {
                        isLoading = true
                        viewModel.fetchWeatherInfoForLocation(query: "\(selectedLocation.lat),\(selectedLocation.lon)") { result in
                            isLoading = false
                        }
                    }
                }
            }
        }
    }
}
