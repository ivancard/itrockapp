//
//  AmenitiesCell.swift
//  IziPark
//
//  Created by fabian zarate on 30/03/2023.
//

import UIKit

class AmenitiesCell: UICollectionViewCell {
    
    @IBOutlet weak var iconCheck: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        contentView.borderConfiguration(borderWidth: 1, borderColor: UIColor(red: 0, green: 0, blue: 0, alpha: 0.04), cornerRadius: 9)
    }
    
    func cellSelect(){
        contentView.borderConfiguration(borderWidth: 1, borderColor: UIColor.primary, cornerRadius: 9)
       
        UIView.animate(withDuration: 0) {
            self.iconCheck.alpha = 1
        }     
    }
    
    func cellDiselect(){
        contentView.borderConfiguration(borderWidth: 1, borderColor: UIColor(red: 0, green: 0, blue: 0, alpha: 0.04), cornerRadius: 9)
        
        UIView.animate(withDuration: 0) {
            self.iconCheck.alpha = 0
        }
    }
}
