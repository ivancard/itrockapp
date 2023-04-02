//
//  ProfileViewController.swift
//  Izipark
//
//  Created by fabian zarate on 24/01/2023.
//

import UIKit

final class ProfileViewController: BaseViewController {

    @IBOutlet weak var spotDropDown: UIButton!
    @IBOutlet weak var helpButton: UIButton!
    @IBOutlet weak var historyButton: UIButton!
    @IBOutlet weak var editButton: UIButton!
    @IBOutlet weak var mapBannerHeightConstraint: NSLayoutConstraint!

    var hasSpotsCreated: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configView()
    }
   
    private func configView() {
        setDropdownSpotState()
        setbuttonStyle()
        setBannerHeight()
    }
    
    private func setbuttonStyle() {
        for buton in [helpButton, historyButton, editButton] {
            buton?.layer.borderWidth = 0.3
            buton?.layer.borderColor = UIColor(named: "darkGray")?.cgColor
        }
    }
    private func setBannerHeight() {
        if hasSpotsCreated {
            mapBannerHeightConstraint.constant = 135
        } else {
            mapBannerHeightConstraint.constant = 162
        }
    }

    func setDropdownSpotState(){
        let optionClosure = {(action: UIAction) in

            let popup = SpotStatePopUpViewController()
            popup.delegate = self

            if action.title == "DISPONIBLE" {
                self.spotDropDown.backgroundColor = #colorLiteral(red: 0.1254901961, green: 0.3450980392, blue: 0.137254902, alpha: 1)
                popup.config(state: "Disponible")
            } else {
                self.spotDropDown.backgroundColor = #colorLiteral(red: 0.5019607843, green: 0.5019607843, blue: 0.5019607843, alpha: 1)
                popup.config(state: "No disponible")
            }
            
            popup.show(on: self, from: .bottom)
        }
        spotDropDown.menu = UIMenu(children:[
            UIAction(title: "DISPONIBLE", state: .on ,handler: optionClosure),
            UIAction(title: "NO DISPONIBLE", handler: optionClosure)
        ])

        spotDropDown.showsMenuAsPrimaryAction = true
        if #available(iOS 15.0, *) {
            spotDropDown.changesSelectionAsPrimaryAction = true
        } else {
            // Fallback on earlier versions
        }
    }

    @IBAction func historyAction(_ sender: UIButton) {
        navigationController?.pushViewController(PayHistoryViewController(), animated: true)
    }
}

//MARK: - StatePopUpDelegate

extension ProfileViewController: StatePopUpDelegate {
    func didCancelUpdateState() {

    }
}
