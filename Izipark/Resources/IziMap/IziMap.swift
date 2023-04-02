//
//  IziMap.swift
//  Izipark
//
//  Created by fabian zarate on 25/01/2023.
//
import UIKit
import Foundation
import MapboxMaps


class IziMap {
    private static let centerCoordinate = CLLocationCoordinate2D(latitude: -34.6481661, longitude:-58.5622869 )
    private static let ACCES_TOKEN = "pk.eyJ1IjoicGFibG9tYW50aW5hbiIsImEiOiJjbGM1Y29peTUzcXNrM3Bwbm43ZndtNmpqIn0.bHnRveoBmJ8vwyiUosXPXw"
    private static  let myResourceOptions = ResourceOptions(accessToken: ACCES_TOKEN )
    private static  var map : MapView!
    

     static func getMap(frame : CGRect) -> MapView{
         let myMapInitOptions = mapInitOptions()
         map = MapView(frame: frame, mapInitOptions: myMapInitOptions)
         map.autoresizingMask = [.flexibleWidth, .flexibleHeight]
         map.location.options.activityType = .other
         let configuration = Puck2DConfiguration(topImage: UIImage.iconLocationUser)
         map.location.options.puckType = .puck2D(configuration)
        return map
    }
                                               
    private static func mapInitOptions()-> MapInitOptions{
            return MapInitOptions(resourceOptions: myResourceOptions,
                                 cameraOptions: CameraOptions(center: centerCoordinate, zoom: 12))
    }
    
   
}
extension MapView {
    
    func markerSpot(){
        let ramos = CLLocationCoordinate2D(latitude: -34.6481661, longitude:-58.5622869 )
        let sanJusto = CLLocationCoordinate2D(latitude: -34.6874658714639, longitude:-58.564746373271895 )
        let villaLuzuriaga = CLLocationCoordinate2D(latitude: -34.671337326483574, longitude:-58.59337455242611)
        let moron = CLLocationCoordinate2D(latitude: -34.6557355510383, longitude:-58.61689216074578)
        
        var pointAnnotation1 = PointAnnotation(coordinate: ramos)
        pointAnnotation1.image = .init(image: UIImage.iconLocationSpot ?? UIImage(),name: "icon_spot")
        pointAnnotation1.iconAnchor = .bottom
        
        var pointAnnotation2 = PointAnnotation(coordinate: sanJusto)
        pointAnnotation2.image = .init(image: UIImage.iconLocationSpot ?? UIImage(),name: "icon_spot")
        pointAnnotation2.iconAnchor = .bottom
        
        var pointAnnotation3 = PointAnnotation(coordinate: villaLuzuriaga)
        pointAnnotation3.image = .init(image: UIImage.iconLocationSpot ?? UIImage(),name: "icon_spot")
        pointAnnotation3.iconAnchor = .bottom
        
        var pointAnnotation4 = PointAnnotation(coordinate: moron)
        pointAnnotation4.image = .init(image: UIImage.iconLocationSpot ?? UIImage(),name: "icon_spot")
        pointAnnotation4.iconAnchor = .bottom
        
       
        let pointAnnotationManager = annotations.makePointAnnotationManager()
        pointAnnotationManager.annotations = [pointAnnotation1,pointAnnotation2,pointAnnotation3,pointAnnotation4]
    }
  
   
}
