//
//  AvailabilityScheduleViewController.swift
//  Izipark
//
//  Created by ivan cardenas on 28/03/2023.
//

import UIKit

final class AvailabilityScheduleViewController: BaseViewController {

    @IBOutlet weak var daysView: UIView!
    @IBOutlet weak var fullTimeView: UIView!
    @IBOutlet weak var partTimeView: UIView!
    @IBOutlet weak var firstTurnView: UIView!
    @IBOutlet weak var secondTurnView: UIView!
    @IBOutlet weak var thirdTurnView: UIView!
    @IBOutlet weak var promoImage: UIImageView!
    @IBOutlet var partTimeText: [UILabel]!
    @IBOutlet var partTimeEditButtons: [UIButton]!
    @IBOutlet var fullTimeText: [UILabel]!
    @IBOutlet var daysButtons: [UIButton]!

    let daysSelected: [Days]

    var isFullTimeSelected = false {
        didSet {
            if isFullTimeSelected {
                fullTimeView.backgroundColor = #colorLiteral(red: 1, green: 0.9999999404, blue: 0.9999999404, alpha: 1)
                fullTimeView.borderConfiguration(borderWidth: 2, borderColor: UIColor(named: "Primary"), cornerRadius: 8)
                partTimeText.forEach { $0.textColor = UIColor(red: 0.70, green: 0.70, blue: 0.70, alpha: 1.00) }
                partTimeEditButtons.forEach { $0.isEnabled = false }
            } else {
                fullTimeView.backgroundColor = #colorLiteral(red: 0.862745098, green: 0.862745098, blue: 0.862745098, alpha: 1)
                partTimeText.forEach { $0.textColor = UIColor(named: "Black") }
                partTimeEditButtons.forEach { $0.isEnabled = true }
            }
        }
    }

    var isPartTimeSelected = false {
        didSet {
            if isPartTimeSelected {
                partTimeView.backgroundColor = #colorLiteral(red: 1, green: 0.9999999404, blue: 0.9999999404, alpha: 1)
                fullTimeText.forEach { $0.textColor = UIColor(red: 0.70, green: 0.70, blue: 0.70, alpha: 1.00) }
                partTimeView.borderConfiguration(borderWidth: 2, borderColor: UIColor(named: "Primary"), cornerRadius: 8)
                firstTurnView.borderConfiguration(borderWidth: 2, borderColor: UIColor(named: "Primary"), cornerRadius: 8)
                secondTurnView.borderConfiguration(borderWidth: 2, borderColor: UIColor(named: "Primary"), cornerRadius: 8)
                thirdTurnView.backgroundColor = #colorLiteral(red: 0.862745098, green: 0.862745098, blue: 0.862745098, alpha: 1)
            } else {
                partTimeView.backgroundColor = #colorLiteral(red: 0.862745098, green: 0.862745098, blue: 0.862745098, alpha: 1)
                fullTimeText.forEach { $0.textColor = UIColor(named: "Black") }
                firstTurnView.layer.borderWidth = 0
                secondTurnView.layer.borderWidth = 0
                thirdTurnView.backgroundColor = #colorLiteral(red: 1, green: 0.9999999404, blue: 0.9999999404, alpha: 1)
            }
        }
    }

    init(daysSelected: [Days]) {
        self.daysSelected = daysSelected
        super.init(nibName: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setBorders()
        setStyles()
        setGestures()
        setDays()
    }

    @objc private func scheduleSelected() {
        setBorders()
        isFullTimeSelected.toggle()
        isPartTimeSelected = false
    }

    @objc private func scheduleSelectedPartTime() {
        setBorders()
        isPartTimeSelected.toggle()
        isFullTimeSelected = false
    }

    private func setBorders() {
        [daysView, fullTimeView, partTimeView].forEach {
            $0.borderConfiguration(borderWidth: 1, borderColor: UIColor(red: 0.81, green: 0.81, blue: 0.81, alpha: 1.00), cornerRadius: 8)
        }
    }

    private func setStyles() {
        promoImage.dropShadow(shadowOpacity: 0.8)
    }

    private func setGestures() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(scheduleSelected))
        fullTimeView.addGestureRecognizer(tapGesture)
        let tapGesturePartTime = UITapGestureRecognizer(target: self, action: #selector(scheduleSelectedPartTime))
        partTimeView.addGestureRecognizer(tapGesturePartTime)
    }

    private func setDays() {
        var i = 0
        daysButtons.forEach { button in
            daysSelected.forEach { day in
                if Days.allCases[button.tag] == daysSelected[i] {

                }
                i += 1
            }
        }
    }
}
