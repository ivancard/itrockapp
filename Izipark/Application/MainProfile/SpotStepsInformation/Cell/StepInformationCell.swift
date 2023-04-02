//
//  StepInformationCell.swift
//  Izipark
//
//  Created by fabian zarate on 28/03/2023.
//

import UIKit

final class StepInformationCell: UITableViewCell {

    @IBOutlet weak private var descriptionStep: UILabel!
    @IBOutlet weak private var titleStep: UILabel!
    @IBOutlet weak private var numberStep: UILabel!
    @IBOutlet weak private var imageStep: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    func config(spotStepInformation : SpotStepInformation){
        descriptionStep.text = spotStepInformation.descriptionStep
        titleStep.text = spotStepInformation.titleStep
        numberStep.text = spotStepInformation.stepNumber
        imageStep.image = UIImage(named: spotStepInformation.imageStep ?? "")
    }
}
