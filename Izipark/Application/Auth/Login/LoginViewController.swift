//
//  LoginViewController.swift
//  Izipark
//
//  Created by ivan cardenas on 22/12/2022.
//

import UIKit
import Combine

final class LoginViewController: BaseViewController {

    @IBOutlet weak var loginButton: IziButton!
    @IBOutlet weak var passwordTextField: IziTextField!
    @IBOutlet weak var emailTextField: IziTextField!
    @IBOutlet weak var appleButton: AppleAuthButton!
    @IBOutlet weak var googleButton: GoogleAuthButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        passwordTextField.addAccessoryView(.showHidePassword)

        appleButton.delegate = self
        googleButton.delegate = self
        validateFields()
    }
    
    private func validateFields() {
        let validEmail = emailTextField.textPublisher(for: [.notEmpty, .validEmail])
        let validPassword = passwordTextField.textPublisher(for: [.notEmpty])
        
        Publishers.CombineLatest(validEmail, validPassword)
            .map { $0 && $1 }
            .assign(to: \.isValid, on: loginButton)
            .store(in: &cancellables)
    }
    
    @IBAction func loginAction(_ sender: Any) {
        loading = true
        
        APIClient.Auth.Login(email: emailTextField.text,
                             password: passwordTextField.text)
            .dispatch(showError: false)
            .sink(
                receiveCompletion: { [weak self] result in
                    switch result {
                    case .failure:
                        self?.showError("Credenciales inválidas")
                    default: break
                    }
                    
                    self?.loading = false
                },
                receiveValue: { user in
                    user.save()
                    NavigationHelper.enterApp()
                })
            .store(in: &cancellables)
    }
    
    @IBAction func registerButton(_ sender: Any) {
        navigationController?.pushViewController(RegisterViewController(), animated: true)
    }
    
    @IBAction func forgotPasswordAction(_ sender: Any) {
        navigationController?.pushViewController(ForgotPasswordViewController(), animated: true)
    }
}

//MARK: - GoogleSignInDelegate
extension BaseViewController: GoogleSignInDelegate {
    func didSetGoogleCredentials(googleId: String, googleToken: String) {
        loading = true
        
        APIClient.Auth.RegisterGoogle(googleId: googleId, googleToken: googleToken)
            .dispatch()
            .sink(
                receiveCompletion: { [weak self] (error) in
                    self?.loading = false
                
                    switch error {
                    case .finished:
                        NavigationHelper.enterApp()
                    case .failure:
                        self?.showError()
                    }
                },
                receiveValue: { user in
                    user.save()
                })
            .store(in: &cancellables)
    }
}

//MARK: - AppleSignInDelegate
extension BaseViewController: AppleSignInDelegate {
    func didSetCredential(id: String?, name: String?, email: String?) {
        loading = true
        
        APIClient.Auth.RegisterApple(appleId: id,
                                     fullName: name,
                                     email: email)
        .dispatch()
        .sink(
            receiveCompletion: { [weak self] (completion) in
                self?.loading = false
                
                switch completion {
                case .finished:
                    NavigationHelper.enterApp()
                case .failure:
                    self?.showError()
                }
            },
            receiveValue: { (user) in
                user.save()
            })
        .store(in: &cancellables)
    }
}

