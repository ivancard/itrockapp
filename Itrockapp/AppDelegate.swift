//
//  AppDelegate.swift
//  Itrockapp
//
//  Created by Ivan Cardenas on 22/12/2022.
//

import UIKit
import IQKeyboardManagerSwift
import GoogleSignIn

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        UISearchController().obscuresBackgroundDuringPresentation = false
        
        IQKeyboardManager.shared.enable = true
        IQKeyboardManager.shared.shouldResignOnTouchOutside = true
        
        GoogleManager.startServices()
        
        let titleTextAttributesSelect = [NSAttributedString.Key.foregroundColor: UIColor.white]
        let titleTextAttributesNormal = [NSAttributedString.Key.foregroundColor: UIColor.disabled,
                                        NSAttributedString.Key.font: UIFont.Poppins.bold(withSize: 14)]
        UISegmentedControl.appearance().setTitleTextAttributes(titleTextAttributesSelect, for: .selected)
        UISegmentedControl.appearance().setTitleTextAttributes(titleTextAttributesNormal, for: .normal)
        
        UINavigationBar.appearance().tintColor = .primary
        UINavigationBar.appearance().backIndicatorTransitionMaskImage = .iconRowBack
        UINavigationBar.appearance().backIndicatorImage = .iconRowBack
        
        return true
    }

    func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any] = [:]) -> Bool {
        var handled: Bool

        handled = GIDSignIn.sharedInstance.handle(url)

        if handled {
            return true
        }

        return false
    }
}

