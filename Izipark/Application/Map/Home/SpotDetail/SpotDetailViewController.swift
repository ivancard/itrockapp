//
//  SpotDetailViewController.swift
//  Izipark
//
//  Created by fabian zarate on 07/03/2023.
//

import UIKit

final class SpotDetailViewController: BaseViewController {

    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.configure(delegate: self, dataSource: self,cells: [ReviewsCell.self])
        navigationItem.leftBarButtonItem = .Custom.title(text: "Detalles del Spot")
        tabBarController?.tabBar.isHidden = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        tabBarController?.tabBar.isHidden = false
    }
    
}

extension SpotDetailViewController:UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeue(cellType: ReviewsCell.self)
        return cell
    }
}
