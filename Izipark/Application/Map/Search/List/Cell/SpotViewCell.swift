//
//  SpotViewCell.swift
//  Izipark
//
//  Created by fabian zarate on 19/01/2023.
//

import UIKit

final class SpotViewCell: UITableViewCell {

    @IBOutlet weak private var imageSpotNoDisponible: UIImageView!
    @IBOutlet weak private var btnSpotDisponible: IziButton!
    @IBOutlet weak private var btnSeeMore: UIButton!

    var seeMoreAction: (()->Void)?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        imageSpotNoDisponible.isHidden = true
    }
    
    func configure(available: Bool) {
        imageSpotNoDisponible.isHidden = !available
    }
    
    @IBAction func seeMoreAction(_ sender: Any) {
        seeMoreAction?()
    }
    
    func btnSpotDisponibleTitle(_ title : String){
        btnSpotDisponible.titleLabel?.text = title
    }
    
}
