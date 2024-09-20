//
//  SceneDelegate.swift
//  Itrockapp
//
//  Created by Ivan Cardenas on 22/12/2022.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let entryPoint = (scene as? UIWindowScene) else { return }
        
        window = UIWindow(windowScene: entryPoint)
        window?.rootViewController = SplashViewController()
        window?.makeKeyAndVisible()

        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        appDelegate.window = self.window
    }
}

