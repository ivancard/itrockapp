//
//  MapHelper.swift
//  Izipark
//
//  Created by fabian zarate on 26/01/2023.
//

import UIKit
import Foundation
import MapboxMaps

final class MapHelper {
    
    private static let ACCESS_TOKEN = "pk.eyJ1IjoicGFibG9tYW50aW5hbiIsImEiOiJjbGM1Y29peTUzcXNrM3Bwbm43ZndtNmpqIn0.bHnRveoBmJ8vwyiUosXPXw"
    private static  let myResourceOptions = ResourceOptions(accessToken: ACCESS_TOKEN )
    private static  var map : MapView!
    
    static func getMap(frame : CGRect) -> MapView {
        let myMapInitOptions = mapInitOptions()
        map = MapView(frame: frame, mapInitOptions: myMapInitOptions)
        map.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        map.location.options.activityType = .other
        let configuration = Puck2DConfiguration(topImage: UIImage.iconLocationUser)
        map.location.options.puckType = .puck2D(configuration)
        return map
    }
                                               
    private static func mapInitOptions()-> MapInitOptions{
        return MapInitOptions(resourceOptions: myResourceOptions)
    }
}

extension MapView {
    func createCircleAnotation(coordinate: CLLocationCoordinate2D)-> CircleAnnotation{
        var circleAnnotation = CircleAnnotation(centerCoordinate: coordinate)
        circleAnnotation.circleColor = StyleColor(UIColor.primary)
        circleAnnotation.circleRadius = 80.0
        circleAnnotation.circleOpacity = 0.4
        circleAnnotation.circleStrokeWidth = 50.0
        circleAnnotation.circleStrokeColor = StyleColor(UIColor.primary)
        circleAnnotation.circleStrokeOpacity = 0.25
        return circleAnnotation
    }
    
    func createPointCircle(coordinate: CLLocationCoordinate2D)-> PointAnnotation{
        var pointAnnotation = PointAnnotation(coordinate: coordinate)
        pointAnnotation.image = .init(image: UIImage.iconPointCircle! ,name: "pointCircle")
        pointAnnotation.iconAnchor = .center
        return pointAnnotation
    }
    
    func createSpot(coordinate: CLLocationCoordinate2D)-> PointAnnotation{
        var pointAnnotation = PointAnnotation(coordinate: coordinate)
        pointAnnotation.image = .init(image: UIImage.iconLocationSpot! ,name: "Spot")
        pointAnnotation.iconAnchor = .center
        return pointAnnotation
    }
    
    func createLocation(coordinate: CLLocationCoordinate2D)-> PointAnnotation{
        var pointAnnotation = PointAnnotation(coordinate: coordinate)
        pointAnnotation.image = .init(image: UIImage.iconDestino! ,name: "Location")
        pointAnnotation.iconAnchor = .center
        return pointAnnotation
    }
    
    func cameraAnimateLocation(newLocation: CLLocationCoordinate2D, zoom : CGFloat = 14.0) {
        camera.fly(to: CameraOptions(center: newLocation,zoom: zoom), duration: 0.0)
    }
    
    func irASpot(userLocation : CLLocationCoordinate2D, spotLocation : CLLocationCoordinate2D )-> PolylineAnnotation{
        let lineCoordinates = [
            userLocation,
            spotLocation
        ]
        var lineAnnotation = PolylineAnnotation(lineCoordinates: lineCoordinates)
        lineAnnotation.lineColor = StyleColor(UIColor.black)
        lineAnnotation.lineWidth = 7
        return lineAnnotation
    }
}
