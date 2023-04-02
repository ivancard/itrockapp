//
//  CreateSpotStepsViewController.swift
//  Izipark
//
//  Created by fabian zarate on 28/03/2023.
//

import UIKit

final class CreateSpotStepsViewController: BaseViewController {

    @IBOutlet weak var starButton: IziButton!
    @IBOutlet weak var tableView: UITableView!
    
    private var createSpotsInformation = [
    SpotStepInformation(stepNumber: "1",
                        descriptionStep: "Solo necesitaremos algunos datos para registrar tu Spot y estaremos listos para empezar.",
                        titleStep: "Sobre tu Spot",
                        imageStep: "imageStepOne"),
    
    SpotStepInformation(stepNumber: "2",
                        descriptionStep: "Solo necesitaremos algunos datos para registrar tu Spot y estaremos listos para empezar.",
                        titleStep: "Disponibilidad",
                        imageStep: "imageStepTwo"),
    
    SpotStepInformation(stepNumber: "3",
                        descriptionStep: "Solo necesitaremos algunos datos para registrar tu Spot y estaremos listos para empezar.",
                        titleStep: "Ultimos detalles",
                        imageStep: "imageStepThree")
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tabBarController?.tabBar.isHidden = true
        tableView.configure(delegate: self, dataSource: self, cells: [StepInformationCell.self])
    }
    
    @IBAction func starButtonAction(_ sender: Any) {
        let vc = CreateSpotViewController()
        navigationController?.pushViewController(vc, animated: true)
    }
    
}

extension CreateSpotStepsViewController : UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        createSpotsInformation.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeue(cellType: StepInformationCell.self)
        cell.config(spotStepInformation: createSpotsInformation[indexPath.row])
        return cell
    }
    
    
}
