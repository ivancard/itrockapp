//
//  UIBarButtonItem+Extension.swift
//  Izipark
//
//  Created by Nicolas Bolzan on 16/03/2023.
//

import UIKit

extension UIBarButtonItem {
    enum Custom {}
}

extension UIBarButtonItem.Custom {
    
    static func title(text: String) -> UIBarButtonItem {
        let button = UIButton(frame: .zero)
        button.contentHorizontalAlignment = .left
        button.setTitle(text, for: .normal)
        button.setTitleColor(#colorLiteral(red: 0.1294117647, green: 0.1294117647, blue: 0.1294117647, alpha: 1), for: .normal)
        button.titleLabel?.font = UIFont.Poppins.semibold(withSize: 18)
        button.titleLabel?.lineBreakMode = .byWordWrapping
        button.titleLabel?.numberOfLines = 0
        return UIBarButtonItem(customView: button)
    }
    
    static func image(image: UIImage?, color: UIColor? = nil, target: Any? = nil, action: Selector? = nil) -> UIBarButtonItem {
        let item = UIBarButtonItem(image: image?.withRenderingMode(.alwaysOriginal), style: .done, target: target, action: action)
        item.tintColor = color
        return item
    }
}
