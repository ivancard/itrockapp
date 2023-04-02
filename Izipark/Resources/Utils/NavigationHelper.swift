//
//  NavigationHelper.swift
//  Izipark
//
//  Created by Nicolas Bolzan on 22/12/2022.
//

import UIKit

enum NavigationHelper {
    static func setRoot(viewController: UIViewController, animated: Bool) {
        guard
            let window = UIApplication.shared.windows.first(where: { $0.isKeyWindow }) ?? UIApplication.shared.windows.first
        else { return }
        
        if (animated == false || window.rootViewController == nil) {
            window.rootViewController = viewController
        } else if let snapshot = window.snapshotView(afterScreenUpdates: true) {
            
            viewController.view.addSubview(snapshot)
            
            window.rootViewController = viewController
            
            UIView.animate(
                withDuration: 0.35,
                animations: { snapshot.layer.opacity = 0 },
                completion: { _ in snapshot.removeFromSuperview() }
            )
        }
    }
    
     static func enterApp() {
        let vc = TabBarController()
        NavigationHelper.setRoot(viewController: vc, animated: true)
    }
    
    static func toLogin() {
        let vc = LoginViewController()
        let nc = UINavigationController(rootViewController: vc)
        NavigationHelper.setRoot(viewController: nc, animated: true)
   }
}

extension UINavigationController {
    func previousController<T: UIViewController>(is controllerType: T.Type) -> Bool {
        guard viewControllers.count > 2 else { return false }
        return viewControllers[viewControllers.count - 2] is T
    }
}
