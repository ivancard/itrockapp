//
//  NavigationDelegate.swift
//  Izipark
//
//  Created by Nicolas Bolzan on 23/03/2023.
//

import UIKit
import MapboxCoreNavigation
import MapboxNavigation
import MapboxDirections
import MapboxMaps

class NavigationDelegate: BaseViewController, NavigationViewControllerDelegate {
    
    func lineWidthExpression(_ multiplier: Double = 1.0) -> Expression {
        let lineWidthExpression = Exp(.interpolate) {
            Exp(.linear)
            Exp(.zoom)
            
            RouteLineWidthByZoomLevel.multiplied(by: multiplier)
        }
        
        return lineWidthExpression
    }
    
    func navigationViewController(_ navigationViewController: NavigationViewController, routeLineLayerWithIdentifier identifier: String, sourceIdentifier: String) -> LineLayer? {
        var lineLayer = LineLayer(id: identifier)
        lineLayer.source = sourceIdentifier
        lineLayer.lineColor = .constant(.init(identifier.contains("main") ? UIColor.black  : #colorLiteral(red: 0.6, green: 0.6, blue: 0.6, alpha: 1)))
        lineLayer.lineWidth = .expression(lineWidthExpression())
        lineLayer.lineJoin = .constant(.round)
        lineLayer.lineCap = .constant(.round)
        
        return lineLayer
    }
    
    func navigationViewController(_ navigationViewController: NavigationViewController, routeCasingLineLayerWithIdentifier identifier: String, sourceIdentifier: String) -> LineLayer? {
        var lineLayer = LineLayer(id: identifier)
        lineLayer.source = sourceIdentifier
        lineLayer.lineColor = .constant(.init(identifier.contains("main") ? UIColor.black  : #colorLiteral(red: 0.4, green: 0.4, blue: 0.4, alpha: 1)))
        lineLayer.lineWidth = .expression(lineWidthExpression(1.2))
        lineLayer.lineJoin = .constant(.round)
        lineLayer.lineCap = .constant(.round)
        
        return lineLayer
    }
    
    func navigationViewController(_ navigationViewController: NavigationViewController, didArriveAt waypoint: Waypoint) -> Bool {
        let isFinalLeg = navigationViewController.navigationService.routeProgress.isFinalLeg
        
        if isFinalLeg {
            DispatchQueue.main.asyncAfter(deadline: .now() + 2, execute: {
                navigationViewController.dismiss(animated: true) {
                    let spotLLegada = SpotLlegadaViewController()
                    spotLLegada.show()
                }
            })
            return true
        }
        
        return false
    }
    
    func navigationViewControllerDidDismiss(_ navigationViewController: NavigationViewController, byCanceling canceled: Bool) {
   
        let popup = PopupViewController(
            title: "¿Deseas salir?",
            subtitle: "Abandonarás la navegación al Spot",
            secondaryButtonItem: .init(title: "Salir", action: { [weak self] in
                self?.dismiss(animated: true)
                navigationViewController.navigationService.stop()
                navigationViewController.dismiss(animated: true)
            }),
            primaryButtonItem: .init(title: "Continuar")
        )
        
        popup.show(on: navigationViewController)
    }
    
    func navigationViewController(_ navigationViewController: NavigationViewController,
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
        
    }
}
