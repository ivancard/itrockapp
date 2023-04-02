//
//  ValidateSmsViewController.swift
//  Izipark
//
//  Created by ivan cardenas on 24/01/2023.
//

import UIKit

final class ValidateSmsViewController: BaseViewController {

    @IBOutlet weak var continueButton: IziButton!
    @IBOutlet weak var firstTextField: UITextField!
    @IBOutlet weak var secondTextfield: UITextField!
    @IBOutlet weak var thirdTextField: UITextField!
    @IBOutlet weak var fourthTextField: UITextField!
    
    var code = ""
    let email: String
    var isPhoneWritten: Bool = false {
        didSet {
            if isPhoneWritten {
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
    
    init(email: String) {
        self.email = email
        
        super.init()
    }
    
    private func verificateCode(){
        if  firstTextField.text?.trimmingCharacters(in: .whitespaces) != "" &&
            secondTextfield.text?.trimmingCharacters(in: .whitespaces) != "" &&
            thirdTextField.text?.trimmingCharacters(in: .whitespaces) != "" &&
            fourthTextField.text?.trimmingCharacters(in: .whitespaces) != "" {
            isPhoneWritten = true
            code = (firstTextField.text ?? "") + (secondTextfield.text ?? "") + (thirdTextField.text ?? "") + (fourthTextField.text ?? "")
        } else {
            isPhoneWritten = false
        }
    }
    
    @IBAction func continueButton(_ sender: Any) {
        NavigationHelper.setRoot(viewController: SuccessSmsValidationViewController(), animated: true)
//        validateCode()
    }
    
    @IBAction func firstTextField(_ sender: UITextField) {
        secondTextfield.becomeFirstResponder()
    }
    
    @IBAction func secondTextField(_ sender: UITextField) {
        thirdTextField.becomeFirstResponder()
    }
    
    @IBAction func thirdTextField(_ sender: UITextField) {
        fourthTextField.becomeFirstResponder()
    }
    @IBAction func fourthTextField(_ sender: UITextField) {
        sender.resignFirstResponder()
        verificateCode()
    }
}

extension ValidateSmsViewController {
    private func validateCode() {
        loading = true
        
        APIClient.Auth.SendCodeValidation(email: email,
                                          code: code)
            .dispatch()
            .sink(
                receiveCompletion: { [weak self] _ in
                    self?.loading = false
                },
                receiveValue: { _ in
                    NavigationHelper.setRoot(viewController: SuccessSmsValidationViewController(), animated: true)
                })
            .store(in: &cancellables)
    }
}
