//
//  CarSizeViewController.swift
//  Izipark
//
//  Created by fabian zarate on 28/03/2023.
//

import UIKit

final class CarSizeViewController: BaseViewController {


    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.configure(delegate: self, dataSource: self, cells: [TypeSpotCarCell.self])
    }

}

extension CarSizeViewController : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeue(cellType: TypeSpotCarCell.self)
        cell.iconCar.isHidden = false
        cell.imageStep.isHidden = true
        
        if indexPath.row == 0 {
            cell.titleTypeSpot.text = "Auto Estandar"
            cell.descriptionStep.text = "Solo necesitaremos algunos datos para registrar tu Spot y estaremos."
            cell.iconCar.image = UIImage(named: "iconStandardCar")
        }else if indexPath.row == 1 {
            cell.titleTypeSpot.text = "Auto Grande"
            cell.descriptionStep.text = "Solo necesitaremos algunos datos para registrar tu Spot y estaremos."
            cell.iconCar.image = UIImage(named: "iconBigCar")
        }else {
            cell.titleTypeSpot.text = "Auto XL"
            cell.descriptionStep.text = "Solo necesitaremos algunos datos para registrar tu Spot y estaremos."
            cell.iconCar.image = UIImage(named: "iconCarXL")
        }
        return cell
    }
    
    
    
}
