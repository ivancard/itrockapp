//
//  CardView.swift
//  Izipark
//
//  Created by fabian zarate on 29/01/2023.
//

import Foundation
import UIKit

@IBDesignable class CardView : UIView {
    
    @IBInspectable var cornRadius : CGFloat = 12
    
    override func layoutSubviews() {
       self.layoutIfNeeded()
       createShadow()
   }
    func createShadow(){
        layer.shadowColor = UIColor(red: 0, green: 0.463, blue: 0.372, alpha: 0.1).cgColor
        layer.shadowOpacity = 1
        layer.shadowRadius = 14
        layer.shadowOffset = CGSize(width: 1, height: 2)
        layer.bounds = bounds
        layer.position = center
        layer.cornerRadius = cornRadius
    }

}
