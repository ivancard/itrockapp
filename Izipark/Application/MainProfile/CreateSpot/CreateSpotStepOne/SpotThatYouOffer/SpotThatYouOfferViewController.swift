//
//  SpotThatYouOfferViewController.swift
//  Izipark
//
//  Created by fabian zarate on 28/03/2023.
//

import UIKit

final class SpotThatYouOfferViewController: BaseViewController {

    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.configure(delegate: self, dataSource: self, cells: [TypeSpotCarCell.self])
    }

}

extension SpotThatYouOfferViewController : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeue(cellType: TypeSpotCarCell.self)
        
        if indexPath.row == 1 {
            cell.imageStep.image = UIImage(named:"imgOnStreetStep")
            cell.titleTypeSpot.text = "On Street"
            cell.descriptionStep.text = "On-Steet Spot es el espacios de calle frente a tu garage o driveway."
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        var sizeRow : CGFloat = 0.0
        if indexPath.row == 0 {
            sizeRow = 169.0
        }else{
            sizeRow = 124
        }
        return sizeRow
    }
    
}
