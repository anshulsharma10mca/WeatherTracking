//
//  Searchbar.swift
//  Weather Tracker
//
//  Created by Anshul Sharma on 12/23/24.
//

import SwiftUI

public struct SearchBar: UIViewRepresentable {
    @Binding var text: String
    @Binding var isSearching: Bool
    @Binding var shouldTriggerSearch: Bool

    public func makeUIView(context: Context) -> UISearchBar {
        let searchBar = UISearchBar()
        searchBar.searchBarStyle = .minimal
        searchBar.delegate = context.coordinator
        searchBar.placeholder = "Search location"
        return searchBar
    }

    public func updateUIView(_ uiView: UISearchBar, context: Context) {
        uiView.text = text
    }

    public func makeCoordinator() -> Coordinator {
        return Coordinator(text: $text, isSearching: $isSearching, shouldTriggerSearch:$shouldTriggerSearch)
    }

    public class Coordinator: NSObject, UISearchBarDelegate {
        @Binding var text: String
        @Binding var isSearching: Bool
        @Binding var shouldTriggerSearch: Bool

        private var searchTimer: Timer?

        init(text: Binding<String>, isSearching: Binding<Bool>, shouldTriggerSearch: Binding<Bool>) {
            _text = text
            _isSearching = isSearching
            _shouldTriggerSearch = shouldTriggerSearch
        }

        public func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
            text = searchText
            isSearching = true
            shouldTriggerSearch = false
            
            // Invalidate previous timer
            searchTimer?.invalidate()

            // Schedule a new timer to trigger search after a delay
            searchTimer = Timer.scheduledTimer(withTimeInterval: 0.5, repeats: false) { _ in
                self.shouldTriggerSearch = true
            }
        }

        public func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
            shouldTriggerSearch = true // Set flag when search button is clicked
        }

        public func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
            isSearching = true
        }

        public func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
            isSearching = false
        }

        public func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
            text = ""
            isSearching = false
            shouldTriggerSearch = false
        }
    }
}
