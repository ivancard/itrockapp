//
//  AvailabilityTableViewCell.swift
//  Izipark
//
//  Created by ivan cardenas on 29/03/2023.
//

import UIKit

class AvailabilityTableViewCell: UITableViewCell {

    @IBOutlet weak var scheduleView: UIView!
    @IBOutlet weak var cellView: UIView!

    override func awakeFromNib() {
        super.awakeFromNib()
        setBorders()
    }

    private func setBorders() {
        scheduleView.borderConfiguration(borderWidth: 2, borderColor: UIColor(named: "Primary"), cornerRadius: 8)
        cellView.borderConfiguration(borderWidth: 1, borderColor: UIColor(red: 0.81, green: 0.81, blue: 0.81, alpha: 1.00), cornerRadius: 8)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
