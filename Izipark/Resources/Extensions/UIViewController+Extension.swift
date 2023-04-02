//
//  UIViewController+Extension.swift
//  Izipark
//
//  Created by ivan cardenas on 10/03/2023.
//

import UIKit

extension UIViewController {

    func add(viewController: UIViewController, to container: UIView) {
        container.translatesAutoresizingMaskIntoConstraints = false
        viewController.view.translatesAutoresizingMaskIntoConstraints = false
        container.addSubview(viewController.view)
        viewController.view.topAnchor.constraint(equalTo: container.topAnchor).isActive = true
        viewController.view.leadingAnchor.constraint(equalTo: container.leadingAnchor).isActive = true
        viewController.view.bottomAnchor.constraint(equalTo: container.bottomAnchor).isActive = true
        viewController.view.trailingAnchor.constraint(equalTo: container.trailingAnchor).isActive = true
        self.addChild(viewController)
        viewController.didMove(toParent: self)
    }

    func remove() {
        willMove(toParent: nil)
        view.removeFromSuperview()
        removeFromParent()
    }
}

extension UIViewController {
    
    class func getTopViewController() -> UIViewController? {
        if let navigationController = getNavigationController() {
            return navigationController.visibleViewController
        }
        
        if let rootController = UIApplication.shared.windows.filter({ $0.isKeyWindow }).first?.rootViewController {
            
            var currentController: UIViewController! = rootController
            
            while( currentController.presentedViewController != nil ) {
                
                currentController = currentController.presentedViewController
            }
            return currentController
        }
        
        return nil
    }
    
    class func getNavigationController() -> UINavigationController? {
        if let navigationController = UIApplication.shared.windows.filter({ $0.isKeyWindow }).first?.rootViewController  {
            
            return navigationController as? UINavigationController
        }
        return nil
    }
}
