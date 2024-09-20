//
//  UIFont+Poppins.swift
//  Izipark
//
//  Created by Nicolas Bolzan on 22/12/2022.
//

import UIKit

extension UIFont {
    struct Poppins {
        static func regular(withSize size: CGFloat) -> UIFont {
            return UIFont(name: "Poppins-Regular", size: size)!
        }

        static func semibold(withSize size: CGFloat) -> UIFont {
            return UIFont(name: "Poppins-SemiBold", size: size)!
        }
        
        static func bold(withSize size: CGFloat) -> UIFont {
            return UIFont(name: "Poppins-Bold", size: size)!
        }
    }
}
