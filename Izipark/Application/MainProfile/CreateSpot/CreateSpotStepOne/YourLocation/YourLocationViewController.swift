//
//  YourLocationViewController.swift
//  Izipark
//
//  Created by fabian zarate on 28/03/2023.
//

import UIKit

final class YourLocationViewController: BaseViewController {

    @IBOutlet weak var mapView: IziMap!
    override func viewDidLoad() {
        super.viewDidLoad()
        mapView.layer.cornerRadius = 8
        // Do any additional setup after loading the view.
    }

}
