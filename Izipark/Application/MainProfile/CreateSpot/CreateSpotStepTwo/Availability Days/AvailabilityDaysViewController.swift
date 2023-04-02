//
//  AvailabilityDaysViewController.swift
//  Izipark
//
//  Created by ivan cardenas on 28/03/2023.
//

import UIKit

enum Days: CaseIterable {
    case monday, tuesday, wednesday, thursday, friday, saturday, sunday
}

final class AvailabilityDaysViewController: BaseViewController {

    @IBOutlet weak var continueButton: IziButton!

    var areDaysSelected = false {
        didSet {
            if areDaysSelected {
                continueButton.isValid = true
            } else {
                continueButton.isValid = false
            }
            self.prepareForInterfaceBuilder()
        }
    }

    var daysSelected = [Days]()

    override func viewDidLoad() {
        super.viewDidLoad()

    }

    private func validate() {
        if !daysSelected.isEmpty {
            areDaysSelected = true
        } else {
            areDaysSelected = false
        }
    }

    @IBAction func daySelected(_ sender: UIButton) {
        sender.isSelected.toggle()
        let daySelected = Days.allCases[sender.tag]
        if sender.isSelected {
            sender.backgroundColor = UIColor(named: "Primary")
            daysSelected.append(daySelected)
        } else {
            sender.backgroundColor = UIColor.white
            daysSelected = daysSelected.filter {$0 != daySelected}
        }
        validate()
    }

    @IBAction func continueButton(_ sender: UIButton) {
        navigationController?.pushViewController(AvailabilityScheduleViewController(daysSelected: daysSelected), animated: true)
    }
}
