//
//  CreateSpotStepOneViewController.swift
//  Izipark
//
//  Created by fabian zarate on 28/03/2023.
//

import UIKit

final class CreateSpotStepOneViewController: BaseViewController {

    @IBOutlet weak var containerPageController: UIView!
    private let pageViewController: BasePageViewController

    init(page: Int = 0) {
        let controllers = [
            CarSizeViewController(),
            SpotThatYouOfferViewController(),
            AdditionalInformationViewController(),
            AboutSpotViewController(),
            YourLocationViewController(),
            AmenitieSpotViewController()
        ]
    
        self.pageViewController = BasePageViewController(viewControllers: controllers, swipeEnabled: false)
        super.init()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        add(viewController: pageViewController, to: containerPageController)
    }

}
