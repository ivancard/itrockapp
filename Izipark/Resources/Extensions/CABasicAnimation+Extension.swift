//
//  CABasicAnimation+Extension.swift
//  Izipark
//
//  Created by fabian zarate on 03/02/2023.
//

import Foundation
import UIKit

extension CABasicAnimation {
    static let rotation : CABasicAnimation = {
        let animation = CABasicAnimation(keyPath: "transform.rotation.z")
        animation.repeatCount = 3
        animation.fromValue = 0
        animation.toValue = CGFloat.pi * 2
        animation.duration = 1.0
        return animation
    }()
}
