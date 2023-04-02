//
//  HomeViewModel.swift
//  Izipark
//
//  Created by Nicolas Bolzan on 17/03/2023.
//

import UIKit
import CoreLocation
import MapboxCoreNavigation
import MapboxNavigation
import MapboxDirections
import MapboxMaps
import Combine

final class HomeViewModel {
    
    let navigationViewController = PassthroughSubject<NavigationViewController, Never>()
    
    @Published var searchLocation: CLLocationCoordinate2D?
    
    lazy var direcciones: [CLLocationCoordinate2D] = [
        .init(latitude: -34.6493143,
              longitude: -58.6227197),
        .init(latitude: -34.633418381182025,
              longitude: -58.57092231566708),
        .init(latitude: -34.680870981448905,
              longitude: -58.67042177200012),
        .init(latitude: -34.68059434913235,
              longitude: -58.66984341669699),
        .init(latitude: -34.6557355510383,
              longitude: -58.61689216074578)
    ]
        
    func requestRoute(destinationSpot: CLLocationCoordinate2D?, userLocation: Location?) {
        guard let destinationSpot = destinationSpot,
              let userLocation = userLocation else { return }
        
        let location = CLLocation(latitude: userLocation.coordinate.latitude,
                                  longitude: userLocation.coordinate.longitude)

        let userWaypoint = Waypoint(location: location,
                                    heading: userLocation.heading,
                                    name: "user")

        let destinationWaypoint = Waypoint(coordinate: destinationSpot)
        
        let navigationRouteOptions = NavigationRouteOptions(waypoints: [userWaypoint, destinationWaypoint])
        navigationRouteOptions.locale = Locale(identifier: "es")
        
        Directions.shared.calculate(navigationRouteOptions) { [weak self] (_, result) in
            switch result {
            case .failure(let error):
                print(error.localizedDescription)
                
            case .success(let response):
                self?.basicNavigation(with: response, from: userLocation.location)
            }
        }
    }
    
    private func basicNavigation(with response: RouteResponse, from userLocation: CLLocation) {
        let indexedRouteResponse = IndexedRouteResponse(routeResponse: response, routeIndex: 0)
        let navigationService = MapboxNavigationService(indexedRouteResponse: indexedRouteResponse,
                                                        customRoutingProvider: NavigationSettings.shared.directions,
                                                        credentials: NavigationSettings.shared.directions.credentials,
                                                        simulating: .always)
        
        let navigationOptions = NavigationOptions(navigationService: navigationService)
        let navigationViewController = NavigationViewController(for: indexedRouteResponse,navigationOptions: navigationOptions)
        
        navigationViewController.modalPresentationStyle = .fullScreen
        
        navigationViewController.navigationMapView?.moveUserLocation(to: userLocation)
        navigationViewController.routeLineTracksTraversal = true
        
        navigationViewController.navigationView.wayNameView.alpha = 0.0
        navigationViewController.navigationView.floatingStackView.alpha = 0.0
        navigationViewController.navigationView.speedLimitView.alpha = 0.0
        
        navigationViewController.floatingButtons = []
        navigationViewController.showsSpeedLimits = false
        
        self.navigationViewController.send(navigationViewController)
    }
}
