//
//  SpotStatePopUpViewController.swift
//  Izipark
//
//  Created by ivan cardenas on 13/03/2023.
//

import UIKit

protocol StatePopUpDelegate {
    func didCancelUpdateState()
}

final class SpotStatePopUpViewController: BasePopup {

    @IBOutlet weak var stateLabel: UILabel!

    var stateString: String?
    var delegate: StatePopUpDelegate?

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func viewDidAppear(_ animated: Bool) {
        stateLabel.text = "¿Estas seguro de cambiar tu estado a \(stateString!)?"
    }

    func config(state: String) {
        stateString = state
    }

    @IBAction func cancelAction(_ sender: Any) {
        delegate?.didCancelUpdateState()
        dismiss()
    }
    
    @IBAction func changeStateAction(_ sender: UIButton) {
        dismiss()
    }
}
