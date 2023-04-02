//
//  DeleteAccountPopUpViewController.swift
//  Izipark
//
//  Created by ivan cardenas on 09/03/2023.
//

import UIKit

final class DeleteAccountPopUpViewController: BasePopup {

    override func viewDidLoad() {
        super.viewDidLoad()

    }
    @IBAction func noDelete(_ sender: UIButton) {
        self.dismiss()
    }
    
    @IBAction func Delete(_ sender: UIButton) {
        self.dismiss()
    }
}
