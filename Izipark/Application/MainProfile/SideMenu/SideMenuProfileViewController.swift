//
//  SideMenuProfileViewController.swift
//  Izipark
//
//  Created by ivan cardenas on 09/03/2023.
//

import UIKit

protocol SideMenuProfileDelegate: AnyObject {
    func showController(_ controller: UIViewController)
}

final class SideMenuProfileViewController: BasePopup {
    
    weak var delegate: SideMenuProfileDelegate?
    
    @IBAction func logOutAction(_ sender: UIButton) {
        let popup = PopupViewController(
            title: "Cerrar sesión",
            subtitle: "¿Deseas cerrar sesión?",
            secondaryButtonItem: .init(title: "No"),
            primaryButtonItem: .init(title: "Si, cerrar sesión",
                                     action: { [weak self] in
                                         self?.logout()
                                     }))
        popup.show(on: self)
    }
    
    private func logout() {
        loading = true
        
        APIClient.Auth.LogOut()
            .dispatch()
            .sink(
                receiveCompletion: { [weak self] _ in
                    self?.loading = false
                },
                receiveValue:  { _ in
                    User.current?.clear()
                    NavigationHelper.toLogin()
                })
            .store(in: &cancellables)
    }
    
    private func deleteAccount() {
        loading = true
        
        APIClient.User.DeleteAccount()
            .dispatch(showError: false)
            .sink(
                receiveCompletion: { [weak self] result in
                    switch result {
                    case .failure:
                        self?.showError("No se pudo eliminar la cuenta, intente de nuevo más tarde.")
                    default: break
                    }
                    
                    self?.loading = false
                    
                },
                receiveValue:  { _ in
                    User.current?.clear()
                    NavigationHelper.toLogin()
                })
            .store(in: &cancellables)
    }
    
    @IBAction func deleteAccountButton(_ sender: UIButton) {
        let popup = PopupViewController(
            title: "Eliminar cuenta",
            subtitle: "¿Estás seguro que deseas eliminar tu cuenta en IZI PARK?",
            secondaryButtonItem: .init(title: "No", action: { [weak self] in
                self?.dismiss(animated: true)
            }),
            primaryButtonItem: .init(title: "Si, eliminar",
                                     action: { [weak self] in
                                         self?.dismiss(animated: true)
//                                         self?.deleteAccount()
                                     }))
        popup.show(on: self)
    }
    
    @IBAction func goToTerms(_ sender: UIButton) {
        let vc = TermsAndConditionsViewController(terms: true)
        delegate?.showController(vc)
    }
    
    @IBAction func goToBankData(_ sender: UIButton) {
        let vc = BankDataViewController()
        delegate?.showController(vc)
    }
    
    @IBAction private func goToPrivacy(_ sender: UIButton) {
        let vc = TermsAndConditionsViewController(terms: false)
        delegate?.showController(vc)
    }
}

