//
//  ForgotPasswordViewController.swift
//  Izipark
//
//  Created by ivan cardenas on 22/12/2022.
//

import UIKit
import Combine

final class ForgotPasswordViewController: BaseViewController {

    @IBOutlet weak var continueButton: IziButton!
    @IBOutlet weak var emailTextField: IziTextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        validateFields()
    }
    
    private func forgotPassword() {
        guard let email = emailTextField.text, email.isValidEmail else {
            showAlert(message: "Verifique el correo electrónico")
            return
        }
        
        APIClient.Auth.ForgotPassword(email: email)
            .dispatch()
            .sink(
                receiveCompletion: { _ in },
                receiveValue: { [weak self] _ in
                    let vc = ValidateResetPasswordViewController()
                    self?.navigationController?.pushViewController(vc, animated: true)
                })
            .store(in: &cancellables)
    }

    func validateFields() {
        let validEmail = emailTextField.textPublisher(for: [.notEmpty, .validEmail])
        validEmail
            .assign(to: \.isValid, on: continueButton)
            .store(in: &cancellables)
    }

    @IBAction func resetPasswordAction(_ sender: Any) {
        forgotPassword()
    }
}
