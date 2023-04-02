//
//  TypeSpotCarCell.swift
//  IziPark
//
//  Created by fabian zarate on 29/03/2023.
//

import UIKit

class TypeSpotCarCell: UITableViewCell {

    @IBOutlet weak var iconCar: UIImageView!
    @IBOutlet weak var titleTypeSpot: UILabel!
    @IBOutlet weak var imageStep: UIImageView!
    @IBOutlet weak var imageCheck: UIImageView!
    @IBOutlet weak var descriptionStep: UILabel!
    
    override func layoutSubviews() {
        super.layoutSubviews()
        imageStep.layer.cornerRadius = 7
        contentView.frame = contentView.frame.inset(by:  UIEdgeInsets(top: 0, left: 0, bottom: 10, right: 0))
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        if selected {
            imageCheck.isHidden = !selected
            contentView.borderConfiguration(borderWidth: 2, borderColor: UIColor.primary, cornerRadius: 9)
        }else {
            imageCheck.isHidden = !selected
            contentView.borderConfiguration(borderWidth: 1, borderColor: UIColor(red: 0, green: 0, blue: 0, alpha: 0.04), cornerRadius: 9)

        }
    }
    
}
