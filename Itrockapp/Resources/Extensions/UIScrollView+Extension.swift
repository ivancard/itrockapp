//
//  UIScrollView+Extension.swift
//  Izipark
//
//  Created by Nicolas Bolzan on 17/03/2023.
//

import UIKit

extension UIScrollView {
    var currentPage: Int {
        return Int((contentOffset.x + (0.5 * frame.size.width)) / frame.width)
    }
    
    func scrollTo(page: Int, animated: Bool = true) {
        let float = frame.width * CGFloat(page)
        let point = CGPoint(x: float, y: 0)
        
        setContentOffset(point, animated: animated)
    }
}
