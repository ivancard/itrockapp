//
//  ValidationButton.swift
//  Izipark
//
//  Created by Nicolas Bolzan on 21/03/2023.
//

import UIKit
import Combine

class ValidationButton: UIButton {
    
    @IBInspectable @Published var isValid: Bool = true
        
    var cancelable: AnyCancellable?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        backgroundColor = isValid ? .primary : #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        isEnabled = isValid
        
        cancelable = $isValid.sink(receiveValue: { [weak self] enable in
            UIView.animate(withDuration: 0.3, animations: { [weak self] in
                self?.isEnabled = enable
                self?.backgroundColor = enable ? .primary : #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
                self?.layer.shadowColor = enable ? UIColor.primary.cgColor : #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
            })
        })        
    }
}
