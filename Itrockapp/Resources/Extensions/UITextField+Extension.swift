//
//  UITextField+Extension.swift
//  Izipark
//
//  Created by ivan cardenas on 30/01/2023.
//

import UIKit

extension UITextField {
    
    enum CustomAccessoryViewKind: String, CaseIterable {
        case showHidePassword
    }
    
    func addAccessoryView(_ accessoryView: CustomAccessoryViewKind) {
        switch accessoryView {
        case .showHidePassword:
            var image = UIImage(systemName: isSecureTextEntry ? "eye.slash" : "eye")!
            image = image.withTintColor(UIColor(named: "Black")!, renderingMode: .alwaysOriginal)
            configureAccessoryView(image: image,
                                   action: #selector(showPasswordAction))
        }
    }
    
    func configureAccessoryView(image: UIImage, action: Selector? = nil, size: CGFloat = 25) {
        let button = UIButton(frame: CGRect(x: 0, y: 0, width: size, height: size ))
        button.setTitle("", for: .normal)
        button.setImage(image, for: .normal)
        button.imageEdgeInsets = UIEdgeInsets(top: 0, left: -16, bottom: 0, right: 0)
        if let action_ = action {
            button.addTarget(self, action: action_, for: .touchUpInside)
        }
        
        rightViewMode = .always
        rightView = button
    }
    
    @objc func showPasswordAction() {
        isSecureTextEntry = !isSecureTextEntry
        if let passwordButton = rightView as? UIButton {
            var image = UIImage(systemName: isSecureTextEntry ? "eye.slash" : "eye")!
            image = image.withTintColor(UIColor(named: "Black")!, renderingMode: .alwaysOriginal)
            passwordButton.setImage(image, for: .normal)
        }
    }
}
