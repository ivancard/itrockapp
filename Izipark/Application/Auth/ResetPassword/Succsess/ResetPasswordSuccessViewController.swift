//
//  ResetPasswordSuccessViewController.swift
//  Izipark
//
//  Created by Nicolas Bolzan on 22/12/2022.
//

import UIKit

final class ResetPasswordSuccessViewController: BaseViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func backButtonAction(_ sender: Any) {
        NavigationHelper.setRoot(viewController: LoginViewController(), animated: true)
    }
}
