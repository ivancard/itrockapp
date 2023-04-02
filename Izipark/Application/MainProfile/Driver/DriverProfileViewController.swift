//
//  DriverProfileViewController.swift
//  Izipark
//
//  Created by fabian zarate on 24/02/2023.
//

import UIKit

final class DriverProfileViewController: BaseViewController {

    var hasSpotsCreated: Bool = false

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var imageMyCar: UIImageView!
    @IBOutlet weak var myStaysButton: UIButton!
    @IBOutlet weak var createYourSpotView: IziBorderView!
    @IBOutlet weak var mapBannerHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var helpButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        createYourSpotView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(createSpot)))
        imageMyCar.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(myCar)))
        setBannerHeight()
        
        nameLabel.text = User.current?.fullName
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tabBarController?.tabBar.isHidden = false
    }
    
    override init(nibName: String? = nil) {
        super.init(nibName: nibName)
        configItemTabBar(nameTitle: "Mi cuenta", image: UIImage.iconPerfil!)
    }
    
    @IBAction func newCarAction(_ sender: Any) {
        let vc = AgregarNuevoAutoViewController(setCarType: .newCar)
        navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func promotionAction(_ sender: Any) {
        let vc = PromotionViewController()
        navigationController?.pushViewController(vc, animated: true)
    }

    @IBAction func helpButtonAction(_ sender: Any) {
        let vc = HelpViewController()
        navigationController?.pushViewController(vc, animated: true)
    }
    private func setBannerHeight() {
        if hasSpotsCreated {
            mapBannerHeightConstraint.constant = 100
        } else {
            mapBannerHeightConstraint.constant = 162
        }
    }
    
    @objc func createSpot(){
        let vc = CreateSpotStepsViewController()
        navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc func myCar(){
        let vc = AgregarNuevoAutoViewController(setCarType: .myCar)
        navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func myStaysButtonAction(_ sender: Any) {
        let vc = MyStaysViewController()
        navigationController?.pushViewController(vc, animated: true)
    }

    @IBAction func editAction(_ sender: UIButton) {
        
    }
}
