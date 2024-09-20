//
//  UIView+Extension.swift
//  Izipark
//
//  Created by fabian zarate on 28/01/2023.
//

import UIKit

extension UIView {
    
    @IBInspectable var shadow: Bool {
        set { if newValue { dropShadow() }}
        get { return false }
    }
      
    func dropShadow(radius: CGFloat = 2, shadowOpacity: Float = 0.5) {
          self.layer.masksToBounds = false
          self.layer.shadowColor = UIColor.black.cgColor
          self.layer.shadowOpacity = shadowOpacity
          self.layer.shadowOffset = CGSize(width: 1, height: 1)
          self.layer.shadowRadius = radius
          self.layer.shouldRasterize = true
          self.layer.rasterizationScale = UIScreen.main.scale
    }
    
    func addGradientBackground() {
        let gradientView = UIView(frame: CGRect(x: 0, y: 0, width: frame.width, height: frame.height * 0.3))
        gradientView.applyGradient(from: #colorLiteral(red: 0.8635900512, green: 0.8635900512, blue: 0.8635900512, alpha: 1), to: #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0))
        insertSubview(gradientView, at: 0)
    }
    
    func applyGradient(from firstColor: UIColor, to secondColor: UIColor) {
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = bounds
        gradientLayer.colors = [firstColor.cgColor, secondColor.cgColor]
        layer.insertSublayer(gradientLayer, at: 0)
    }
    
    func performFadeAnimation(animated:Bool) {
        guard animated == true else {
            return
        }
        
        self.alpha = 0.0
        
        UIView.animate(withDuration: 0.8) {
            self.alpha = 1.0
        }
    }
}

extension UIView
{
    func shrink(_ shrink: Shrink, duration: Double = 0.15, scale: CGFloat = 0.96) {
        UIView.animate(withDuration: duration, delay: 0, options: [.allowUserInteraction, .beginFromCurrentState], animations: { [weak self] in
            if shrink == .down {
                self?.transform = CGAffineTransform(scaleX: scale, y: scale)
            } else {
                self?.transform = .identity
            }
        }, completion: nil)
    }
    
    func shrink(duration: Double = 0.15, scale: CGFloat = 0.96) {
        UIView.animate(withDuration: duration, delay: 0, options: [.allowUserInteraction, .beginFromCurrentState], animations: { [weak self] in
            self?.transform = CGAffineTransform(scaleX: scale, y: scale)
        }, completion: { _ in
            UIView.animate(withDuration: duration, delay: 0, options: [.allowUserInteraction, .beginFromCurrentState], animations: { [weak self] in
                self?.transform = .identity
            })
        })
    }
}

enum Shrink {
    case down, up
}

extension UIView {
    func borderConfiguration(roundToHalf: Bool = false, borderWidth: CGFloat? = nil,
                                     borderColor: UIColor? = nil, cornerRadius: CGFloat? = nil,
                                     masksToBounds: Bool? = nil) {
                
                if roundToHalf == true {
                    layer.cornerRadius = frame.height / 2
                }
                
                if let _borderWith = borderWidth {
                    layer.borderWidth = _borderWith
                }
                
                if let _borderColor = borderColor {
                    layer.borderColor = _borderColor.cgColor
                }
                
                if let _cornerRadius = cornerRadius {
                    layer.cornerRadius = _cornerRadius
                }
                
                if let masksToBounds_ = masksToBounds {
                    layer.masksToBounds = masksToBounds_
                }
            }
}

extension UIView {
    
    func animateBottomSheet(show : Bool, onCompleted : (() -> Void)?){
        if show{
            frame.origin.y += frame.height
            UIView.animate(withDuration: 0.4, delay: 0.0, usingSpringWithDamping: 0.7, initialSpringVelocity: 4, options: .curveEaseIn, animations: {
                self.frame.origin.y -= self.frame.height
                if onCompleted != nil{
                    DispatchQueue.main.asyncAfter(deadline: .now()+0.5) {
                    onCompleted?()
                    }
                }
            })
            return
        }
        
        UIView.animate(withDuration: 0.4, delay: 0.0, usingSpringWithDamping: 0.7, initialSpringVelocity: 4, options: .curveEaseIn, animations: {
            self.frame.origin.y += self.frame.height
            self.animateOverlay()
            if onCompleted != nil{
                DispatchQueue.main.asyncAfter(deadline: .now()+0.2) {
                    onCompleted?()
                }
            }
        })
    }
    
    func animateOverlay(delay : TimeInterval = 0.0){
        self.alpha = 0
        UIView.animate(withDuration: 0.2, delay: delay, options: .curveEaseIn, animations: {
            self.alpha = 1.0
        })
    }
}
