//
//  IziMap.swift
//  Izipark
//
//  Created by Nicolas Bolzan on 22/03/2023.
//

import UIKit
import MapboxMaps
import Combine

protocol IziMapDelegate: AnyObject {
    func showSpotDetails(_ show: Bool, at index: Int?)
}

final class IziMap: UIView {
    
    @Published var directions: [CLLocationCoordinate2D] = []
    
    private var cancellables = Set<AnyCancellable>()
    
    weak var delegate: IziMapDelegate?
    
    lazy var map: MapView = {
        MapHelper.getMap(frame: frame)
    }()
    
    private lazy var pointAnnotationManager = map.annotations.makePointAnnotationManager()
    private lazy var circleAnnotationManager = map.annotations.makeCircleAnnotationManager()
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        addSubview(map)
        
        map.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            map.topAnchor.constraint(equalTo: topAnchor),
            map.leadingAnchor.constraint(equalTo: leadingAnchor),
            map.trailingAnchor.constraint(equalTo: trailingAnchor),
            map.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        pointAnnotationManager.delegate = self
        map.location.delegate = self
        map.location.locationProvider.startUpdatingLocation()
        
        map.ornaments.options.scaleBar.visibility = .hidden
        map.ornaments.options.compass.visibility = .hidden
        
        $directions
            .sink(receiveValue: { [weak self] _ in
                self?.loadDirections()
            })
            .store(in: &cancellables)
        
        map.mapboxMap.onNext(event: .mapLoaded) { [weak self] _ in
            self?.loadDirections()
        }
    }
    
    private func loadDirections() {
        guard let latestLocation = map.location.latestLocation else {
            return
        }
        
        locationUpdate(newLocation: latestLocation)
        
        directions.forEach { location in
            self.pointAnnotationManager.annotations.append(self.map.createSpot(coordinate: location))
        }
    }
    
    func addCircleAnnotation() {
        guard let location = map.location.latestLocation, circleAnnotationManager.annotations.isEmpty else {
            return
        }
        
        circleAnnotationManager.annotations.append(self.map.createCircleAnotation(coordinate: location.coordinate))
    }
    
    func removeCircleAnnotation() {
        circleAnnotationManager.annotations = []
    }
}


extension IziMap: LocationPermissionsDelegate, LocationConsumer {
    func locationUpdate(newLocation: MapboxMaps.Location) {
        map.camera.fly(to: CameraOptions(center: newLocation.coordinate, zoom: 14.0), duration: 3)
    }
}

extension IziMap: AnnotationInteractionDelegate {
    func annotationManager(_ manager: AnnotationManager, didDetectTappedAnnotations annotations: [Annotation]) {
        
        if let destination = (annotations.first as? PointAnnotation)?.point.coordinates,
           let index = directions.firstIndex(of: destination) {
            delegate?.showSpotDetails(true, at: index)
        }
    }
}
