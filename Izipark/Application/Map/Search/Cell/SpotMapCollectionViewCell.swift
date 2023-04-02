//
//  SpotMapCollectionViewCell.swift
//  Izipark
//
//  Created by fabian zarate on 23/02/2023.
//

import UIKit

final class SpotMapCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var imageSpotNoDisponible: UIImageView!
    @IBOutlet weak var btnMoreAction: UIButton!
    @IBOutlet weak var BtnGoToTheSpot: IziButton!
    
    var seeMoreAction: (()->Void)?
    var goToTheSpot: (()->Void)?
    
    var spotDisponible = true {
        didSet {
            imageSpotNoDisponible.isHidden = spotDisponible
        }
    }
    
    @IBAction func seeMoreActvion(_ sender: Any) {
        seeMoreAction?()
    }
    
    @IBAction func goToTheSpotAction(_ sender: Any) {
        goToTheSpot?()
    }
    
}
