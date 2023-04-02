//
//  SeparatorPayTableViewCell.swift
//  Izipark
//
//  Created by ivan cardenas on 28/02/2023.
//

import UIKit

final class SeparatorPayTableViewCell: UITableViewCell {

    @IBOutlet weak var monthLabel: UILabel!
    @IBOutlet weak var stateLabel: UILabel!

    let currentMonth = "Febrero"

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    func config(month: String) {
        monthLabel.text = month
        if month == currentMonth {
            stateLabel.text = "No disponible"
            stateLabel.textColor = #colorLiteral(red: 0.7137254902, green: 0.7137254902, blue: 0.7137254902, alpha: 1)
        } else {
            stateLabel.text = "Ver liquidacion"
            stateLabel.textColor = #colorLiteral(red: 0.2274509804, green: 0.6117647059, blue: 0.8235294118, alpha: 1)
        }
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
