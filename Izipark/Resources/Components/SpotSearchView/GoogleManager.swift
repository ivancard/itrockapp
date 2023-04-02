//
//  GoogleManager.swift
//  IziPark
//
//  Created by Jonathan Montes de Oca on 29/03/2023.
//

import Foundation
import Combine
import GooglePlaces
import GoogleMapsPlatformCombine

enum GoogleManager {
    enum Places {}
}

extension GoogleManager {
    static func startServices() {
        GMSPlacesClient.provideAPIKey("AIzaSyBzTR0ppEKSpmdswWRGSidlzccuedkeXJw")
    }
}

extension GoogleManager.Places {
    final class PlacesFinder {
        private var cancellables = Set<AnyCancellable>()
        
        private let placesClient = GMSPlacesClient.shared()
        private let sessionToken = GMSAutocompleteSessionToken()
        
        private let filter = GMSAutocompleteFilter()
        
        @Published var keyword: String = ""
        @Published var loading: Bool = false
        @Published var predictions: [GMSAutocompletePrediction] = []
        
        init() {
            filter.country = Locale.current.regionCode
            
            observersSetup()
        }
        
        private func observersSetup() {
            $keyword
                .compactMap { $0 }
                .sink(receiveValue: { [weak self] keyword in
                    self?.loading = true
                    self?.getPredictions(from: keyword)
                }).store(in: &cancellables)
        }
        
        private func getPredictions(from keyword: String) {
            placesClient
                .findAutocompletePredictions(from: keyword,
                                                     filter: filter,
                                                     sessionToken: sessionToken)
                .sink(
                    receiveCompletion: { _ in },
                    receiveValue: { [weak self] predictions in
                    self?.predictions = predictions
                })
                .store(in: &cancellables)
        }
        
        func getInfo(for placeID: String) -> AnyPublisher<GMSPlace, Error> {
            loading = true
            
            return GMSPlacesClient.shared()
                .fetchPlace(id: placeID,
                            fields: .all)
                .eraseToAnyPublisher()
        }
    }
}
