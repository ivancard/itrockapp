//
//  SpotLlegadaViewController.swift
//  Izipark
//
//  Created by fabian zarate on 19/01/2023.
//

import UIKit

final class SpotLlegadaViewController: BasePopup {
    
    @IBAction func actionButtonPay(_ sender: Any) {
        let vc = MercadoPagoViewController()
        let nc = UINavigationController(rootViewController: vc)
        navigationController?.pushViewController(nc, animated: true)
    }
    
    @IBAction func cancelSpotAction(_ sender: IziButton) {
        dismiss() {
            let vc = WhatHappenedViewController()
            vc.show()
        }
    }
    
    @IBAction func searchButtonAction(_ sender: Any) {
        dismiss()
    }
}
