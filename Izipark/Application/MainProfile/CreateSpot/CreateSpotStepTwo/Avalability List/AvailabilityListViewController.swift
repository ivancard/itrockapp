//
//  AvailabilityListViewController.swift
//  Izipark
//
//  Created by ivan cardenas on 29/03/2023.
//

import UIKit

final class AvailabilityListViewController: BaseViewController {

    @IBOutlet weak var addbutton: UIView!
    @IBOutlet weak var availabilitiesTableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        setBorders()
        availabilitiesTableView.configure(delegate: self, dataSource: self, cells: [AvailabilityTableViewCell.self], showIndicators: false)
    }

    private func setBorders() {
        addbutton.borderConfiguration(borderWidth: 1, borderColor: UIColor(red: 0.81, green: 0.81, blue: 0.81, alpha: 1.00), cornerRadius: 8)
    }
}

//MARK: - UITableViewDelegate

extension AvailabilityListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        1
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeue(cellType: AvailabilityTableViewCell.self)
        return cell
    }
}
