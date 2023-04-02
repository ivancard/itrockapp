//
//  IziTextField.swift
//  Izipark
//
//  Created by Nicolas Bolzan on 22/12/2022.
//

import UIKit
import SkyFloatingLabelTextField

final class IziTextField: SkyFloatingLabelTextField {
    
    override var text: String? {
        didSet {
            sendActions(for: .valueChanged)
        }
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)

        font = UIFont.Poppins.regular(withSize: 14)
        titleFont = UIFont.Poppins.regular(withSize: 10)
        placeholderFont = UIFont.Poppins.regular(withSize: 14)

        backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        tintColor = .primary
        textColor = .black
        errorColor = #colorLiteral(red: 1, green: 0.3152095901, blue: 0.366369709, alpha: 1)
        placeholderColor = .lightGray
        titleColor = .black
        selectedTitleColor = .black
        selectedLineHeight = 0
        lineHeight = 0
        disabledColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        
        titleFormatter = { text in
            text
        }
        
        borderStyle = .none
        layer.masksToBounds = true
        layer.cornerRadius = 8
        layer.borderWidth = 0.2
        layer.borderColor = UIColor.lightGray.cgColor
        
        addTarget(self, action: #selector(editingStart), for: .editingDidBegin)
        addTarget(self, action: #selector(editingEnd), for: .editingDidEnd)
    }
    
    @objc private func editingStart() {
        layer.borderColor = UIColor.primary.cgColor
    }
    
    @objc private func editingEnd() {
        layer.borderColor = UIColor.lightGray.cgColor
    }
    
    override func titleLabelRectForBounds(_ bounds: CGRect, editing: Bool) -> CGRect {
        return bounds.inset(by: .init(top: -22, left: 10, bottom: 0, right: 10))
    }
    
    override func textRect(forBounds bounds: CGRect) -> CGRect {
        if text?.isEmpty == true {
            return bounds.inset(by: .init(top: 0, left: 10, bottom: 0, right: 10))
        } else {
            return bounds.inset(by: .init(top: 12, left: 10, bottom: 0, right: 10))
        }
    }

    override func placeholderRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: .init(top: 0, left: 10, bottom: 0, right: 10))
    }

    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        if text?.isEmpty == true {
            return bounds.inset(by: .init(top: 0, left: 10, bottom: 0, right: 10))
        } else {
            return bounds.inset(by: .init(top: 12, left: 10, bottom: 0, right: 10))
        }
    }
}
