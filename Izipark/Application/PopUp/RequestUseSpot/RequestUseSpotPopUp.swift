//
//  RequestUseSpotPopUp.swift
//  Izipark
//
//  Created by ivan cardenas on 14/03/2023.
//

import UIKit

final class RequestUseSpotPopUp: BasePopup {

    @IBOutlet weak var alertView: UIView!
    @IBOutlet weak var conductorName: UILabel!
    @IBOutlet weak var conductorCarImage: UIImageView!
    @IBOutlet weak var conductorCarModel: UILabel!
    @IBOutlet weak var conductorCarPatente: UILabel!
    @IBOutlet weak var parkPrice: UILabel!
    @IBOutlet weak var parkPay: UILabel!
    @IBOutlet weak var stayFrom: UILabel!
    @IBOutlet weak var stayTo: UILabel!
    @IBOutlet weak var helpButton: UIButton!
    @IBOutlet weak var cancelButton: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        configView()
        timeToCancelOver()
    }

    private func configView() {
        alertView.layer.borderColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0.14)
        alertView.layer.borderWidth = 0.5
    }

    private func timeToCancelOver() {
        
        Timer.scheduledTimer(withTimeInterval: 5.0, repeats: false) { _ in
            self.helpButton.isHidden = false
            self.cancelButton.isHidden = true
            self.alertView.superview?.isHidden = true
            self.animate()
        }
    }

    func animate(){
        UIView.animate(withDuration: 0.5) {
            self.view.layoutIfNeeded()
        }
    }

    @IBAction func acceptAction(_ sender: IziButton) {
        dismiss()
    }
    @IBAction func goToHelp(_ sender: UIButton) {
        dismiss()
    }
}
