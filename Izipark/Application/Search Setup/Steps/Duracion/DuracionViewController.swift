//
//  DuracionViewController.swift
//  Izipark
//
//  Created by fabian zarate on 28/01/2023.
//

import UIKit

final class DuracionViewController: BaseViewController {

    @IBOutlet weak var totalPrice: UILabel!
    @IBOutlet weak var circularProgressView: CircularProgressView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        circularProgressView.delegate = self
        selectedValue(5)
        
    }
}
extension DuracionViewController : CircularProgressViewDelegate {
    
    func selectedValue(_ minutes: Int) {
        UIView.animate(withDuration: 0.1) {
            self.totalPrice.text = "ARS \(minutes * 3)"
        }
    }
}
