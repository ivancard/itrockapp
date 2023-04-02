//
//  PopupViewController.swift
//  Izipark
//
//  Created by Nicolas Bolzan on 09/03/2023.
//

import UIKit

struct PopupButtonItem {
    var title: String
    var action: (()->Void)?
}

class PopupViewController: BasePopup {

    @IBOutlet weak private var topImageView: UIImageView!
    @IBOutlet weak private var titleLabel: UILabel!
    @IBOutlet weak private var subtitleLabel: UILabel!
    @IBOutlet weak private var secondaryButton: UIButton!
    @IBOutlet weak private var primaryButton: UIButton!
    
    private let topImage: UIImage?
    private let topTitle: String?
    private let subtitle: String?
    private let primaryButtonItem: PopupButtonItem?
    private let secondaryButtonItem: PopupButtonItem?
    
    init(topImage: UIImage? = nil, title: String? = nil, subtitle: String? = nil, secondaryButtonItem: PopupButtonItem? = nil, primaryButtonItem: PopupButtonItem? = nil) {
        self.topImage = topImage
        self.topTitle = title
        self.subtitle = subtitle
        self.secondaryButtonItem = secondaryButtonItem
        self.primaryButtonItem = primaryButtonItem
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if topImage != nil {
            topImageView.image = topImage
        }
        titleLabel.text = topTitle
        subtitleLabel.text = subtitle
        secondaryButton.setTitle(secondaryButtonItem?.title, for: [])
        primaryButton.setTitle(primaryButtonItem?.title, for: [])
        
        topImageView.isHidden = topImage == nil
        titleLabel.isHidden = topTitle == nil
        subtitleLabel.isHidden = subtitle == nil
        secondaryButton.isHidden = secondaryButtonItem == nil
        primaryButton.isHidden = primaryButtonItem == nil
    }
    
    @IBAction private func secondaryButtonPressed() {
        dismiss() { [weak self] in
            self?.secondaryButtonItem?.action?()
        }
    }
    
    @IBAction private func primaryButtonPressed() {
        dismiss() { [weak self] in
            self?.primaryButtonItem?.action?()
        }
    }
    
}
