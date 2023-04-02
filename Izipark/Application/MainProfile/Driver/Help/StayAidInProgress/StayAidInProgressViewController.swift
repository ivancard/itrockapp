//
//  StayAidInProgressViewController.swift
//  Izipark
//
//  Created by fabian zarate on 17/03/2023.
//

import UIKit

final class StayAidInProgressViewController: BaseViewController {
    
    @IBOutlet weak var tableView: UITableView!
    private var helpsType  = ["Venció el tiempo de la estadía y el auto sigue ocupando mi Spot",
                              "Venció el tiempo de la estadía y de disponibilidad de mi Spot y el auto sigue estancionado.",
                              "Tengo una urgencia y necesito usar mi Spot",
                              "El conductor dañó mi propiedad o chocó a otro vehiculo al estacionar"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Ayuda con la estadía en curso"
        tableView.configure(delegate: self, dataSource: self, cells: [HelpCell.self], showIndicators: true)
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tabBarController?.tabBar.isHidden = true
    }

}

extension StayAidInProgressViewController : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return helpsType.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeue(cellType: HelpCell.self)
        cell.title.text = helpsType[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 3 {
            let vc = LostAnObjectViewController()
            navigationController?.pushViewController(vc, animated: true)
        }
        if indexPath.row == 0 {
            let vc = HelpPhotoViewController()
            navigationController?.pushViewController(vc, animated: true)
        }
    }
}
