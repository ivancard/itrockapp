//
//  RegisterViewController.swift
//  Izipark
//
//  Created by ivan cardenas on 22/12/2022.
//

import UIKit
import Combine

final class RegisterViewController: BaseViewController {

    @IBOutlet weak var emailTextField: IziTextField!
    @IBOutlet weak var phoneTextField: IziTextField!
    @IBOutlet weak var nameTextField: IziTextField!
    @IBOutlet weak var passwordTextField: IziTextField!
    @IBOutlet weak var checkBoxTerms: UIButton!
    @IBOutlet weak var googleButton: GoogleAuthButton!
    @IBOutlet weak var createButton: IziButton!
    @IBOutlet weak var appleButton: AppleAuthButton!
    @IBOutlet weak var termsLabel: UILabel!

    @Published var isAceptedTerms: Bool = false

    override func viewDidLoad() {
        super.viewDidLoad()
        passwordTextField.addAccessoryView(.showHidePassword)

        appleButton.delegate = self
        googleButton.delegate = self
        
        validateFields()
        setupMultipleTapLabel()
    }

    private func validateFields() {
        let validEmail = emailTextField.textPublisher(for: [.validEmail, .notEmpty])
        let validName = nameTextField.textPublisher(for: [.notEmpty])
        let validPhone = phoneTextField.textPublisher(for: [.notEmpty])
        let validPassword = passwordTextField.textPublisher(for: [.notEmpty])
        
        let validTermsAndPass = Publishers.CombineLatest(validPassword, $isAceptedTerms)
            .map { $0 && $1 }
        
        Publishers.CombineLatest4(validEmail, validName, validPhone, validTermsAndPass)
            .map { $0 && $1 && $2 && $3}
            .assign(to: \.isValid, on: createButton)
            .store(in: &cancellables)
            
    }
    
    private func setupMultipleTapLabel() {
        termsLabel.text = "Acepto las Políticas de Privacidad y Términos y Condiciones."
        let tapAction = UITapGestureRecognizer(target: self, action: #selector(self.tapLabel(gesture:)))
        termsLabel.addGestureRecognizer(tapAction)
    }
        
    @objc private func tapLabel(gesture: UITapGestureRecognizer) {
        if gesture.didTapAttributedTextInLabel(label: termsLabel, targetText: "Términos y Condiciones.") {
            navigationController?.pushViewController(TermsAndConditionsViewController(terms: true), animated: true)
        } else if gesture.didTapAttributedTextInLabel(label: termsLabel, targetText: "Políticas de Privacidad") {
            navigationController?.pushViewController(TermsAndConditionsViewController(terms: false), animated: true)
        }
    }
    
    @IBAction func signInButtonAction(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func registerButtonAction(_ sender: Any) {
        loading = true
        
        APIClient.Auth.Register(fullName: nameTextField.text ?? "",
                                phoneNumber: phoneTextField.text ?? "",
                                email: emailTextField.text ?? "",
                                password: passwordTextField.text ?? "")
        .dispatch(showError: false)
        .sink(
            receiveCompletion: { [weak self] (completion) in
                self?.loading = false
                switch completion {
                case .failure:
                    self?.showError()
                case .finished:
                    break
                }
            },
            receiveValue: { [weak self] user in
                user.save()
                if let email = user.email {
                    let vc = ValidateSmsViewController(email: email)
                    self?.navigationController?.pushViewController(vc, animated: true)
                }
                
            })
        .store(in: &cancellables)
    }
    
    @IBAction func checkBoxAction(_ sender: UIButton) {
        isAceptedTerms.toggle()
        
        if isAceptedTerms {
            sender.backgroundColor = UIColor(named: "Primary")
        } else {
            sender.backgroundColor = .white
            
        }
    }
}
