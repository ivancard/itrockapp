//
//  ResetaPasswordViewController.swift
//  Izipark
//
//  Created by ivan cardenas on 22/12/2022.
//

import UIKit

final class ValidateResetPasswordViewController: BaseViewController {

    @IBOutlet weak var continueButton: IziButton!
    @IBOutlet weak var firstTextField: UITextField!
    @IBOutlet weak var secondTextField: UITextField!
    @IBOutlet weak var thirdTextField: UITextField!
    @IBOutlet weak var fourthTextField: UITextField!

    var isCodeWritten: Bool = false {
        didSet {
            if isCodeWritten {
                self.continueButton.isValid = true
            } else {
                self.continueButton.isValid = false
            }
            continueButton.prepareForInterfaceBuilder()
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        firstTextField.becomeFirstResponder()
    }
    
    private func verificateCode(){
        if  firstTextField.text?.trimmingCharacters(in: .whitespaces) != "" &&
                secondTextField.text?.trimmingCharacters(in: .whitespaces) != "" &&
            thirdTextField.text?.trimmingCharacters(in: .whitespaces) != "" &&
            fourthTextField.text?.trimmingCharacters(in: .whitespaces) != "" {
            isCodeWritten = true
        } else {
            isCodeWritten = false
        }
    }
    
    @IBAction func firstTextField(_ sender: UITextField) {
        secondTextField.becomeFirstResponder()
    }
    @IBAction func secondTextField(_ sender: UITextField) {
        thirdTextField.becomeFirstResponder()
    }
    @IBAction func thirdTextField(_ sender: UITextView) {
        fourthTextField.becomeFirstResponder()
    }
    @IBAction func fourthTextField(_ sender: UITextField) {
        sender.resignFirstResponder()
        verificateCode()
    }
    
    @IBAction func acceptButtonAction(_ sender: Any) {
        let controller = SetNewPasswordViewController()
        navigationController?.pushViewController(controller, animated: true)
    }
}
