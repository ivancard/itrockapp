 //
//  NavigationMapView+Extension.swift
//  Izipark
//
//  Created by fabian zarate on 09/02/2023.
//
import UIKit
import Foundation
import MapboxCoreNavigation
import MapboxNavigation
import MapboxDirections
import MapboxMaps
import Combine


final class IziNavigationMapView : NavigationMapView {
    
    var locationCoordinate : CLLocationCoordinate2D?
    var navigationController : NavigationViewController?
    var requestRouteObservable = PassthroughSubject<Void,Error>()

    var currentRouteIndex = 0 {
        didSet {
            showCurrentRoute()
        }
    }
    
    var currentRoute: Route? {
        return routes?[currentRouteIndex]
    }
    
    var routes: [Route]? {
        return routeResponse?.routes
    }
    
    var routeResponse: RouteResponse? {
        didSet {
            guard currentRoute != nil else {
                self.removeRoutes()
                return
            }
            currentRouteIndex = 0
        }
    }
    
    func showCurrentRoute() {
        guard let currentRoute = currentRoute else { return }
        
        var routes = [currentRoute]
        routes.append(contentsOf: self.routes!.filter {
            $0 != currentRoute
        })
        self.showcase(routes)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    private func setup() {
        self.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        self.delegate = self
        self.userLocationStyle = .puck2D(configuration: configPuck2D())
        
        let navigationViewportDataSource = NavigationViewportDataSource(self.mapView, viewportDataSourceType: .raw)
        navigationViewportDataSource.options.followingCameraOptions.zoomUpdatesAllowed = false
        navigationViewportDataSource.followingMobileCamera.zoom = 13.0
        self.navigationCamera.viewportDataSource = navigationViewportDataSource
    }
    
    func configPuck2D()-> Puck2DConfiguration{
        return Puck2DConfiguration(topImage: UIImage.iconLocationUser)
    }
    
    func requestRoute(destinationSpot: CLLocationCoordinate2D) {
        
        // Locacion Usuario
        guard let userLocation = self.mapView.location.latestLocation else { return }

        let location = CLLocation(latitude: userLocation.coordinate.latitude,
                                  longitude: userLocation.coordinate.longitude)

        let userWaypoint = Waypoint(location: location,
                                    heading: userLocation.heading,
                                    name: "user")

        
        
        // Locacion Destino
        let destinationWaypoint = Waypoint(coordinate: destinationSpot)
        
        let navigationRouteOptions = NavigationRouteOptions(waypoints: [userWaypoint, destinationWaypoint])
        navigationRouteOptions.locale = Locale(identifier: "es")
        
        Directions.shared.calculate(navigationRouteOptions) { [weak self] (_, result) in
            switch result {
            case .failure(let error):
                self?.requestRouteObservable.send(completion: .failure(error))
                print(error.localizedDescription)
            case .success(let response):
                                
                self?.routeResponse = response
                if let routes = self?.routes,
                   let currentRoute = self?.currentRoute {
                    UIView.animate(withDuration: 0.5) {
                         self?.show(routes)
                        self?.showWaypoints(on: currentRoute)
                    }
                }
                self?.basicNavigation()
                self?.requestRouteObservable.send()
            }
        }
    }
    
    private func basicNavigation(){
        guard let response =  routeResponse else {return}
        let indexedRouteResponse = IndexedRouteResponse(routeResponse: response, routeIndex: 0)
        let navigationService = MapboxNavigationService(indexedRouteResponse: indexedRouteResponse,
                                                        customRoutingProvider: NavigationSettings.shared.directions,
                                                        credentials: NavigationSettings.shared.directions.credentials,
                                                        simulating: .always)
        
        let navigationOptions = NavigationOptions(navigationService: navigationService)
        let navigationViewController = NavigationViewController(for: indexedRouteResponse,navigationOptions: navigationOptions)
        
        
        navigationViewController.modalPresentationStyle = .fullScreen
        
        if let latestValidLocation = mapView.location.latestLocation?.location {
        navigationViewController.navigationMapView?.moveUserLocation(to: latestValidLocation)
        }
         
        navigationViewController.routeLineTracksTraversal = true
        
        navigationViewController.navigationView.wayNameView.alpha = 0.0
        navigationViewController.navigationView.floatingStackView.alpha = 0.0
        navigationViewController.navigationView.speedLimitView.alpha = 0.0
        
        navigationViewController.floatingButtons = []
        navigationViewController.showsSpeedLimits = false
        
        navigationController = navigationViewController
    }
    
    private func createaLocationMarker(location: CLLocationCoordinate2D){
        var pointAnnotation = PointAnnotation(coordinate: location)
        pointAnnotation.image = .init(image: UIImage.iconDestino! ,name: "location")
        pointAnnotation.iconAnchor = .center
        
        var pointAnnotation2 = PointAnnotation(coordinate: location)
        pointAnnotation2.image = .init(image: UIImage.circleNavigation! ,name: "circleNavigation")
        pointAnnotation2.iconAnchor = .center
        
        pointAnnotationManager?.annotations.append(pointAnnotation)
        pointAnnotationManager?.annotations.append(pointAnnotation2)
    }
}

extension IziNavigationMapView :  NavigationMapViewDelegate,
                                AnnotationInteractionDelegate {
    
    func annotationManager(_ manager: MapboxMaps.AnnotationManager, didDetectTappedAnnotations annotations: [MapboxMaps.Annotation]) {
        
        annotations.forEach { pointAnnotation in
            guard let spot = pointAnnotation as? PointAnnotation else {return}
            if spot.image?.name == "Spot" {
                UIView.animate(withDuration: 0.5) {
                    self.requestRoute(destinationSpot: spot.point.coordinates)
                } completion: {_ in
                    print("tapeddButtom")
                }
            }
        }
    }
    
    func navigationMapView(_ navigationMapView: MapboxNavigation.NavigationMapView, didSelect route: MapboxDirections.Route) {
        self.currentRouteIndex = self.routes?.firstIndex(of: route) ?? 0
    }
    
    func navigationMapView(_ navigationMapView: NavigationMapView, shapeFor route: Route) -> LineString? {
        return route.shape
    }
    
    func navigationMapView(_ navigationMapView: NavigationMapView, casingShapeFor route: Route) -> LineString? {
        return route.shape
    }
     
    func navigationMapView(_ navigationMapView: NavigationMapView,
                           didAdd finalDestinationAnnotation: PointAnnotation,
                           pointAnnotationManager: PointAnnotationManager) {
        
        var finalDestinationAnnotation = finalDestinationAnnotation
        if let image = UIImage.iconLocationSpot {
            finalDestinationAnnotation.image = .init(image: image, name: "markerSpot")
        } else {
            let image = UIImage(named: "default_marker", in: .mapboxNavigation, compatibleWith: nil)!
            finalDestinationAnnotation.image = .init(image: image, name: "marker")
        }
  
        pointAnnotationManager.annotations = [finalDestinationAnnotation]
        
        if let locationCoordinate = self.locationCoordinate {
            createaLocationMarker(location: locationCoordinate)
        }
    }
    
    func lineWidthExpression(_ multiplier: Double = 1.0) -> Expression {
        let lineWidthExpression = Exp(.interpolate) {
            Exp(.linear)
            Exp(.zoom)
            
            RouteLineWidthByZoomLevel.multiplied(by: multiplier)
        }
        
        return lineWidthExpression
    }
    
    func navigationMapView(_ navigationMapView: NavigationMapView, routeLineLayerWithIdentifier identifier: String, sourceIdentifier: String) -> LineLayer? {
        var lineLayer = LineLayer(id: identifier)
        lineLayer.source = sourceIdentifier
        
        lineLayer.lineColor = .constant(.init(identifier.contains("main") ? UIColor.black :  #colorLiteral(red: 0.6, green: 0.6, blue: 0.6, alpha: 1) ))
        lineLayer.lineWidth = .expression(lineWidthExpression())
        lineLayer.lineJoin = .constant(.round)
        lineLayer.lineCap = .constant(.round)
        
        return lineLayer
    }
    
    func navigationMapView(_ navigationMapView: NavigationMapView, routeCasingLineLayerWithIdentifier identifier: String, sourceIdentifier: String) -> LineLayer? {
        var lineLayer = LineLayer(id: identifier)
        lineLayer.source = sourceIdentifier
        
        lineLayer.lineColor = .constant(.init(identifier.contains("main") ? UIColor.black :#colorLiteral(red: 0.4, green: 0.4, blue: 0.4, alpha: 1)))
        lineLayer.lineWidth = .expression(lineWidthExpression(1.2))
        lineLayer.lineJoin = .constant(.round)
        lineLayer.lineCap = .constant(.round)
        
        return lineLayer
    }

}


