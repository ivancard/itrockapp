//
//  SpotsDisponiblesViewController.swift
//  Izipark
//
//  Created by fabian zarate on 19/01/2023.
//

import UIKit

final class SpotsDisponiblesViewController: BaseViewController {
    
    @IBOutlet weak var viewDetalleDeBusqueda: CardView!
    @IBOutlet weak var spotTableView: UITableView!
    @IBOutlet weak var spotScroolView: UIScrollView!
        
    override func viewDidLoad() {
        super.viewDidLoad()
        configureNavigationBar()
        spotTableView.configure(delegate: self, dataSource: self, cells: [SpotViewCell.self])
    }
    
    private func configureNavigationBar() {
        let back = UIBarButtonItem.Custom.image(image: .iconRowBack,
                                                target: self,
                                                action: #selector(backAction))
        
        let title = UIBarButtonItem.Custom.title(text: "Tu búsqueda")

        navigationItem.leftBarButtonItems =  [back, title]
    }
    
    @objc private func backAction() {
        dismiss(animated: true)
    }
}

extension SpotsDisponiblesViewController: UITableViewDelegate, UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeue(cellType: SpotViewCell.self)
        let available = indexPath.row > 5
        cell.configure(available: available)
        return cell
    }

}
