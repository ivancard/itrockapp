//
//  AutoCargadoExitosamenteViewController.swift
//  Izipark
//
//  Created by fabian zarate on 01/02/2023.
//

import UIKit

final class AutoCargadoExitosamenteViewController: BaseViewController {

    private let pageDestino = 2
    private let homeProfile = 1
    @IBOutlet weak var btnContinuar: IziButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func continuarAction(_ sender: Any) {
        let vc = TabBarController()
        vc.indexTabBar = .profile
        NavigationHelper.setRoot(viewController: vc, animated: true)
    }
    
}
