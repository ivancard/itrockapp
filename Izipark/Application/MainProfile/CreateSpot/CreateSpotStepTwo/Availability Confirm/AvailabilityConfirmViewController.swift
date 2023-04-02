//
//  AvailabilityConfirmViewController.swift
//  Izipark
//
//  Created by ivan cardenas on 28/03/2023.
//

import UIKit

class AvailabilityConfirmViewController: UIViewController {

    @IBOutlet weak var dataView: UIView!
    @IBOutlet weak var scheduleView: UIView!

    override func viewDidLoad() {
        super.viewDidLoad()

        dataView.borderConfiguration(borderWidth: 1, borderColor: UIColor(red: 0.81, green: 0.81, blue: 0.81, alpha: 1.00), cornerRadius: 8)
        scheduleView.borderConfiguration(borderWidth: 1, borderColor: UIColor(named: "Primary"), cornerRadius: 8)
    }
}
