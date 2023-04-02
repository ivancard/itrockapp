//
//  TuAutoViewController.swift
//  Izipark
//
//  Created by fabian zarate on 28/01/2023.
//

import UIKit

final class TuAutoViewController: BaseViewController {
   
    @IBAction func addNewCarAction(_ sender: Any) {
        let vc = SetCarViewController()
        navigationController?.pushViewController(vc, animated: true)
    }
    
}
