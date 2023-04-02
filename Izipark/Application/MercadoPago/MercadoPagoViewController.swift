//
//  MercadoPagoViewController.swift
//  Izipark
//
//  Created by fabian zarate on 13/02/2023.
//

import UIKit

final class MercadoPagoViewController: BaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        DispatchQueue.main.asyncAfter(deadline: .now() + 5, execute: {
            let vc = YourStayViewController()
            self.navigationController?.pushViewController(vc, animated: true)
        })
    }

}
