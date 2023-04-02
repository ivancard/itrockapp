//
//  MainProfileViewController.swift
//  Izipark
//
//  Created by ivan cardenas on 10/03/2023.
//

import UIKit

final class MainProfileViewController: BaseViewController{

    @IBOutlet weak var segmentedControl: UISegmentedControl!
    @IBOutlet weak var viewPageController: UIView!

    private var pageViewController : BasePageViewController!

    private lazy var sideMenu: SideMenuProfileViewController = {
        let menu = SideMenuProfileViewController()
        menu.delegate = self
        return menu
    }()
    
    override init(nibName: String? = nil) {
        super.init(nibName: nibName)
        configItemTabBar(nameTitle: "Mi cuenta", image: UIImage.iconPerfil!)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        configPageView()
        configSegmentedCotrol()
        setNavigationBar()
    }

    private func configPageView() {
        let vcProfile = DriverProfileViewController()
        vcProfile.hasSpotsCreated = true
        let vcSpotsProfile = ProfileViewController()
        vcSpotsProfile.hasSpotsCreated = true
        pageViewController = BasePageViewController(viewControllers: [vcProfile,vcSpotsProfile], delegate: self)
        add(viewController: pageViewController, to: viewPageController)
    }
    
    private func configSegmentedCotrol() {
        segmentedControl.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.white, NSAttributedString.Key.font: UIFont(name: "Poppins-Bold", size: 14)!], for: UIControl.State.selected)
        segmentedControl.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor(named: "darkGray") ?? UIColor.gray, NSAttributedString.Key.font: UIFont(name: "Poppins-Bold", size: 14)!], for: UIControl.State.normal)
        segmentedControl.layer.borderWidth = 1
        segmentedControl.layer.borderColor = UIColor(named: "Disabled")?.cgColor
    }

    private func setNavigationBar() {
        let title = UIBarButtonItem.Custom.title(text: "Mi cuenta")
        
        let menu = UIBarButtonItem.Custom.image(
            image: UIImage(systemName: "line.3.horizontal")!,
            color: #colorLiteral(red: 0.1294117647, green: 0.1294117647, blue: 0.1294117647, alpha: 1),
            target: self,
            action: #selector(sideMenuHandler))
        
        navigationItem.setRightBarButton(menu, animated: true)
        navigationItem.setLeftBarButton(title, animated: true)
    }

    @objc func sideMenuHandler() {
        sideMenu.show(on: self, from: .right)
    }
    
    @IBAction func segmentedChange(_ sender: UISegmentedControl) {
        pageViewController.setPage(sender.selectedSegmentIndex)
    }
}

//MARK: - BasePageViewControllerDelegate

extension MainProfileViewController: BasePageViewControllerDelegate {
    func pageDidChange(_ page: Int) {
        segmentedControl.selectedSegmentIndex = page
    }
}

//MARK: - SideMenuDelegate

extension MainProfileViewController: SideMenuProfileDelegate {
    func showController(_ controller: UIViewController) {
        sideMenu.dismiss()
        navigationController?.pushViewController(controller, animated: true)
    }
}

