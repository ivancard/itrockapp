//
//  RoundShadowView.swift
//  Izipark
//
//  Created by Nicolas Bolzan on 07/03/2023.
//

import UIKit

class RoundShadowView: UIView {
  
    @IBInspectable var cornerRadius: CGFloat = 8
    @IBInspectable var shadowColor: UIColor = .black
    @IBInspectable var shadowOffset: CGSize = CGSize(width: 2, height: 2.0)
    @IBInspectable var shadowOpacity: Float = 0.2
    @IBInspectable var shadowRadius: CGFloat = 13
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        // set the shadow of the view's layer
        layer.shadowColor = shadowColor.cgColor
        layer.shadowOffset = shadowOffset
        layer.shadowOpacity = shadowOpacity
        layer.shadowRadius = shadowRadius
        
        // set the cornerRadius of the containerView's layer
        layer.cornerRadius = cornerRadius
        layer.masksToBounds = false
    }
}

final class RoundShadowButton: UIButton {
  
    @IBInspectable var cornerRadius: CGFloat = 4
    @IBInspectable var shadowColor: UIColor = .black
    @IBInspectable var shadowOffset: CGSize = .zero
    @IBInspectable var shadowOpacity: Float = 0.1
    @IBInspectable var shadowRadius: CGFloat = 1
       
    override func awakeFromNib() {
        super.awakeFromNib()
        
        // set the shadow of the view's layer
        layer.shadowColor = shadowColor.cgColor
        layer.shadowOffset = CGSize(width: 0, height: 1.0)
        layer.shadowOpacity = shadowOpacity
        layer.shadowRadius = shadowRadius
        
        // set the cornerRadius of the containerView's layer
        layer.cornerRadius = cornerRadius
        layer.masksToBounds = false
    }
}
