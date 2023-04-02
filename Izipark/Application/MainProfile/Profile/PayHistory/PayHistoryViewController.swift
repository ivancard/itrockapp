//
//  PayHistoryViewController.swift
//  Izipark
//
//  Created by ivan cardenas on 28/02/2023.
//

import UIKit

enum PayState {
    case pending
    case done
}

struct PayCells {
    let cell: UITableViewCell
    let isSeparator: Bool
    var payState: PayState?
    var month: String?
}

final class PayHistoryViewController: BaseViewController {

    let mockSeparator: [PayCells] = [
        PayCells(cell: SeparatorPayTableViewCell(), isSeparator: true, month: "Febrero"),
        PayCells(cell: PayTableViewCell(), isSeparator: false, payState: .pending),
        PayCells(cell: SeparatorPayTableViewCell(), isSeparator: true, month: "Enero"),
        PayCells(cell: PayTableViewCell(), isSeparator: false, payState: .done),
        PayCells(cell: PayTableViewCell(), isSeparator: false, payState: .done),
        PayCells(cell: PayTableViewCell(), isSeparator: false, payState: .done)
    ]

    @IBOutlet weak var paysTableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        tabBarController?.tabBar.isHidden = true
        configView()
        paysTableView.configure(delegate: self, dataSource: self , cells: [SeparatorPayTableViewCell.self, PayTableViewCell.self])
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        tabBarController?.tabBar.isHidden = false
    }
    
    private func configView() {
        setNavigationBar()
    }

    private func setNavigationBar() {
        let titleLabel = UILabel (frame: CGRect(x: 0, y: 40, width: 320, height: 40))
        titleLabel.center = CGPoint(x: 160, y: 285)
        titleLabel.textAlignment = .left
        titleLabel.text = "Historial"
        titleLabel.font = UIFont(name: "Poppins-SemiBold", size: 18)
        titleLabel.tintColor = #colorLiteral(red: 0.1294117647, green: 0.1294117647, blue: 0.1294117647, alpha: 1)
        self.navigationItem.titleView = titleLabel

        var customBackIcon = UIImage.iconRowBack!
        customBackIcon = customBackIcon.withAlignmentRectInsets(UIEdgeInsets(top: 0, left: -10, bottom: -3, right: 0))
        self.navigationController?.navigationBar.backIndicatorImage = customBackIcon
        self.navigationController?.navigationBar.backIndicatorTransitionMaskImage = customBackIcon
    }
}

//MARK: - TableViewDelegate and dataSource

extension PayHistoryViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        if mockSeparator[indexPath.row].isSeparator {
            let cell = tableView.dequeue(cellType: SeparatorPayTableViewCell.self)
            cell.config(month: mockSeparator[indexPath.row].month ?? "Febrero")
            return cell
        } else {
            let cell = tableView.dequeue(cellType: PayTableViewCell.self)
            cell.config(state: mockSeparator[indexPath.row].payState ?? .pending)
            return cell
        }
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if mockSeparator[indexPath.row].isSeparator {
            return 40
        } else {
            return 160
        }
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        mockSeparator.count
    }

}
