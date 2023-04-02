//
//  PopUpMessageCancelViewController.swift
//  Izipark
//
//  Created by ivan cardenas on 16/03/2023.
//

import UIKit
import MapboxNavigation

final class PopUpMessageCancelViewController: BasePopup {

    @IBOutlet weak var messageLabel: UILabel!
    @IBOutlet weak var primaryButton: UIButton!
    @IBOutlet weak var otherReasonTextField: UITextView!

    let reason: ReasonToCancel

    init(reason: ReasonToCancel) {
        self.reason = reason
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        otherReasonTextField.superview?.isHidden = true
        configView(type: reason)
    }

    private func configView(type: ReasonToCancel) {
        switch reason {
        case .busySpot, .carSizeNotMatch:
            messageLabel.text = "¡Lo sentimos! Avisaremos al dueño del Spot que alguien lo está ocupando sin autorización."
            primaryButton.setTitle("Buscar otro Spot", for: .normal)
        case .changeOpinion:
            messageLabel.text = "¡Muy bien! Avisaremos al dueño del Spot que no lo usarás para que lo verifique y su Spot vuelva a estar disponible."
            primaryButton.isHidden = true
        case .other:
            messageLabel.text = "Ayúdanos a mejorar. Cuéntanos el motivo por el que decides no estacionar"
            primaryButton.setTitle("Enviar", for: .normal)
            setTextView()
            otherReasonTextField.superview?.isHidden = false
        }
    }

    private func setTextView() {
        otherReasonTextField.delegate = self
        otherReasonTextField.borderConfiguration(roundToHalf: false, borderWidth: 0.5, borderColor: UIColor(named: "GreyText"), cornerRadius: 8, masksToBounds: true)
    }
    
    @IBAction func exitButton(_ sender: UIButton) {
        dismiss()
    }

    @IBAction func submitButton(_ sender: UIButton) {
        //action button
        dismiss()
    }
}

//MARK: - TextViewDelegate
extension PopUpMessageCancelViewController: UITextViewDelegate {
    func textViewDidBeginEditing(_ textView: UITextView) {
        textView.text = ""
        textView.textColor = UIColor(named: "Black")
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.trimmingCharacters(in: .whitespaces) == "" {
            textView.text = "¿Tuviste algún problema?"
            textView.textColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.29)
        }
    }
}
