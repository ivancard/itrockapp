//
//  TermsTableViewCell.swift
//  Izipark
//
//  Created by Jonathan Montes de Oca on 28/03/2023.
//

import UIKit

class TermsTableViewCell: UITableViewCell {

    @IBOutlet private var descriptionLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configureCell(text: String) {
        descriptionLabel.text = text
    }
}
