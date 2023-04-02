//
//  SetNewPasswordViewController.swift
//  Izipark
//
//  Created by ivan cardenas on 24/01/2023.
//

import UIKit

final class SetNewPasswordViewController: UIViewController {

    @IBOutlet weak var newPasswordTextField: UITextField!
    @IBOutlet weak var continueButton: IziButton!
    
    var isNewPasswordWritten: Bool = false {
        didSet {
            if isNewPasswordWritten {
                self.continueButton.isValid = true
            } else {
                self.continueButton.isValid = false
            }
            continueButton.prepareForInterfaceBuilder()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        newPasswordTextField.addAccessoryView(.showHidePassword)
        newPasswordTextField.delegate = self
    }
    
    @IBAction func aceptButton(_ sender: Any) {
        NavigationHelper.setRoot(viewController: ResetPasswordSuccessViewController(), animated: true)
    }
}

extension SetNewPasswordViewController: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {

        let updatedString = (textField.text as NSString?)?.replacingCharacters(in: range, with: string)

        textField.text = updatedString
        
        if textField.text?.trimmingCharacters(in: .whitespaces) != "" {
            self.isNewPasswordWritten = true
        } else {
            self.isNewPasswordWritten = false
        }

        return false
    }
}
