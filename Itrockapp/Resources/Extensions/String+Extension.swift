//
//  String+Extension.swift
//  Izipark
//
//  Created by Jonathan Montes de Oca on 17/03/2023.
//

import Foundation

extension String {
    var isValidEmail: Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailTest.evaluate(with: self) || isEmpty == true
    }
}
