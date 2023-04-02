//
//  IziButton.swift
//  Izipark
//
//  Created by Nicolas Bolzan on 22/12/2022.
//

import UIKit

@IBDesignable class IziButton: ValidationButton {

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        prepare()
    }
    
    private func prepare() {
        titleLabel?.font = UIFont.Poppins.bold(withSize: 14)
        backgroundColor = .primary
        layer.masksToBounds = true
        layer.cornerRadius = 8
    }

    override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        prepare()
    }
}
