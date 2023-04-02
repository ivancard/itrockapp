//
//  LostAnObjectViewController.swift
//  Izipark
//
//  Created by fabian zarate on 17/03/2023.
//

import UIKit

final class LostAnObjectViewController: BaseViewController {

    @IBOutlet weak var buttonDetail: IziButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.leftBarButtonItem = .Custom.title(text: "Perdí un objeto")
    }

    @IBAction func buttonDetailAction(_ sender: Any) {
        let vc = LostObjectDescriptionViewController()
        navigationController?.pushViewController(vc, animated: true)
    }
    
}
