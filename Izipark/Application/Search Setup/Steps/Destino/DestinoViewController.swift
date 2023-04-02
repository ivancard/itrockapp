//
//  DestinoViewController.swift
//  Izipark
//
//  Created by fabian zarate on 28/01/2023.
//

import UIKit
import MapboxMaps

final class DestinoViewController: BaseViewController {

    @IBOutlet weak var searchRadius: UILabel!
    @IBOutlet weak var addressLocation: UILabel!
    @IBOutlet weak var mapContainer: UIView!
    
    internal var mapView : MapView!
    lazy var circleAnotationManager = mapView.annotations.makeCircleAnnotationManager()
    lazy var pointAnotationManager = mapView.annotations.makePointAnnotationManager()

    override func viewDidLoad() {
        super.viewDidLoad()
        mapContainer.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        initMap()
        
        if ((SearchLocation.current?.address?.isEmpty) != nil) {
            addressLocation.text = SearchLocation.current?.address
        }
        addressLocation.text = SearchLocation.current?.name
    }
    
    func initMap(){
        mapView = MapHelper.getMap(frame: mapContainer.bounds)
        self.mapContainer.addSubview(mapView)
        
        mapView.mapboxMap.onNext(event: .mapLoaded) { [self]_ in
            
            let searchLocation = CLLocationCoordinate2D(
                latitude: (SearchLocation.current?.latitude)!,
                longitude:(SearchLocation.current?.longitude)!)
            
            self.searchLocationSpot(searchLocation: searchLocation)
            
        }
    }
    
    func searchLocationSpot(searchLocation : CLLocationCoordinate2D) {
        self.circleAnotationManager.annotations.append(self.mapView.createCircleAnotation(coordinate: searchLocation))
        pointAnotationManager.annotations.append(self.mapView.createLocation(coordinate: searchLocation))
        mapView.camera.fly(to: CameraOptions(center: searchLocation, zoom: 14.0), duration: 0.0)
    }
}

