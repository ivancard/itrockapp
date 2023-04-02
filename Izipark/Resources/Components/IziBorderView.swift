//
//  Card.swift
//  Izipark
//
//  Created by fabian zarate on 17/02/2023.
//

import Foundation
import UIKit

final class IziBorderView: RoundShadowView {
    
    @IBInspectable var borderWidth: CGFloat = 1
    @IBInspectable var borderColor: UIColor = UIColor(red: 0.217, green: 0.217, blue: 0.217, alpha: 0.11)
    @IBInspectable var cornerRadiusView: CGFloat = 1
    
    override func layoutSubviews() {
       self.layoutIfNeeded()
       setup()
   }
    
    func setup(){
        layer.borderWidth = borderWidth
        layer.borderColor = borderColor.cgColor
        cornerRadius = cornerRadiusView
    }
    
}
