//
//  BankDataViewController.swift
//  Izipark
//
//  Created by ivan cardenas on 10/03/2023.
//

import UIKit

final class BankDataViewController: BaseViewController {

    @IBOutlet weak var bankDataTextField: UITextField!
    @IBOutlet weak var continueButton: IziButton!

    var isBankDataWritten: Bool = false {
        didSet {
            if isBankDataWritten {
                self.continueButton.isValid = true
            } else {
                self.continueButton.isValid = false
            }
            continueButton.prepareForInterfaceBuilder()
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        bankDataTextField.delegate = self
        title = "Datos Bancarios"
    }
}

//MARK: - TextFieldDelegate

extension BankDataViewController: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {

        let updatedString = (textField.text as NSString?)?.replacingCharacters(in: range, with: string)

        textField.text = updatedString

        if textField.text?.trimmingCharacters(in: .whitespaces) != "" {
            self.isBankDataWritten = true
        } else {
            self.isBankDataWritten = false
        }

        return false
    }
}
