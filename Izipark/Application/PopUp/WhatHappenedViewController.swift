//
//  WhatHappenedViewController.swift
//  Izipark
//
//  Created by fabian zarate on 09/03/2023.
//

import UIKit

enum ReasonToCancel: CaseIterable {
    case busySpot
    case carSizeNotMatch
    case changeOpinion
    case other
}

final class WhatHappenedViewController: BasePopup {
    
    @IBOutlet var reasons: [UIButton]!
    @IBOutlet weak var sendButton: IziButton!
    
    var option: ReasonToCancel? {
        didSet{
            isOptionSelected = true
        }
    }
    
    var isOptionSelected: Bool = false {
        didSet {
            if option != nil {
                sendButton.isValid = true
                sendButton.prepareForInterfaceBuilder()
            }
        }
    }
    
    @IBAction func optionPressed(_ sender: UIButton) {
        for reason in reasons {
            reason.backgroundColor = .clear
            reason.setTitleColor(UIColor(named: "Black"), for: .normal)
        }
        
        sender.backgroundColor = UIColor(named: "Primary")
        sender.setTitleColor(.white, for: .normal)
        
        option = ReasonToCancel.allCases[sender.tag]
    }
    
    private func setPopUp(reason: ReasonToCancel?) {
        guard let reasonOption = reason else {return}
        dismiss() {
            let popup = PopUpMessageCancelViewController(reason: reasonOption)
            popup.show()
        }
    }
    
    @IBAction func sendAction(_ sender: IziButton) {
        setPopUp(reason: option)
    }
    
    @IBAction func omitAction(_ sender: Any) {
        dismiss()
    }
}
