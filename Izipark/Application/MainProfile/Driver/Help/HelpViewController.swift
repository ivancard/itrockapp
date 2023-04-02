//
//  HelpViewController.swift
//  Izipark
//
//  Created by fabian zarate on 17/03/2023.
//

import UIKit

final class HelpViewController: BaseViewController {

    @IBOutlet weak var helpStayInProgress: UIButton!
    @IBOutlet weak var tableView: UITableView!
    private var helpsType  = ["Ayuda con una estadía",
                              "Hay un auto en mi Spot",
                              "Mi cuenta",
                              "Guia de funcionamiento de Izi Park",
                              "¿Necesitas ayuda con esta estadía?"]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.leftBarButtonItem = .Custom.title(text: "Ayuda")
        tabBarController?.tabBar.isHidden = true
        tableView.configure(delegate: self, dataSource: self, cells: [HelpCell.self], showIndicators: true)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        tabBarController?.tabBar.isHidden = false
    }
    @IBAction func helpStayinProgressAction(_ sender: Any) {
        let vc = StayAidInProgressViewController()
        navigationController?.pushViewController(vc, animated: true)
    }
    
}

extension HelpViewController : UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return helpsType.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeue(cellType: HelpCell.self)
        cell.title.text = helpsType[indexPath.row]
        return cell
    }
    

    
    
}
