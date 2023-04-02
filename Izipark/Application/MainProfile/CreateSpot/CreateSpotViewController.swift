//
//  CreateSpotViewController.swift
//  Izipark
//
//  Created by fabian zarate on 28/03/2023.
//

import UIKit

final class CreateSpotViewController: BaseViewController {

    @IBOutlet weak var containerPageController: UIView!

    private let pageViewController: BasePageViewController
    private let pageViewController1: BasePageViewController
    let controllers1 = [AboutSpotViewController(),
                        SpotThatYouOfferViewController(),
                        CarSizeViewController(),
                        YourLocationViewController(),
                        AmenitieSpotViewController(),
                        AdditionalInformationViewController()]

    private let pageViewController2: BasePageViewController
    let controllers2 = [AvailabilityViewController(),
                        AvailabilityListViewController()]

    
    init(page: Int = 0) {
    
        self.pageViewController1 = BasePageViewController(viewControllers: controllers1)
        self.pageViewController2 = BasePageViewController(viewControllers: controllers2)

        let controllers = [pageViewController1,
                           pageViewController2]
        self.pageViewController = BasePageViewController(viewControllers: controllers)

        super.init()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        add(viewController: pageViewController, to: containerPageController)
    }


    @IBAction func continueButton(_ sender: IziButton) {


        if pageViewController.page == 0 {
            if pageViewController1.isLastPage {
                pageViewController.nextPage()
            }
            pageViewController1.nextPage()
        } else if pageViewController.page == 1 {
            if pageViewController.isLastPage { sender.isValid = false}
            pageViewController2.nextPage()
        }
    }
}
