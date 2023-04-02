//
//  PosterIncomingViewController.swift
//  Izipark
//
//  Created by ivan cardenas on 30/01/2023.
//

import UIKit

final class PosterIncomingViewController: BaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func continueButton(_ sender: Any) {
        self.navigationController?.pushViewController(VerifySpotViewController(), animated: true)
    }
}
