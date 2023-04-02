//
//  PayTableViewCell.swift
//  Izipark
//
//  Created by ivan cardenas on 28/02/2023.
//

import UIKit

final class PayTableViewCell: UITableViewCell {

    @IBOutlet weak var adressLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var stayFromLabel: UILabel!
    @IBOutlet weak var stayToLabel: UILabel!
    @IBOutlet weak var payStateLabel: UILabel!
    @IBOutlet weak var payStateIcon: UIImageView!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }



    func config(state: PayState) {

        if state == .pending {
            payStateLabel.text = "Pendiente"
            payStateLabel.textColor = #colorLiteral(red: 0.7137254902, green: 0.7137254902, blue: 0.7137254902, alpha: 1)
            payStateIcon.image = #imageLiteral(resourceName: "iconPendiente")
        } else if state == .done {
            payStateLabel.text = "Liquidado"
            payStateLabel.textColor = #colorLiteral(red: 0.3176470588, green: 0.5254901961, blue: 0.2196078431, alpha: 1)
            payStateIcon.image = #imageLiteral(resourceName: "iconLiquidado")
        }

        payStateLabel.isHidden = false
        payStateIcon.isHidden = false
    }
    
}
