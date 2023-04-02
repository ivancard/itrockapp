//
//  ResultadoBusquedaViewController.swift
//  Izipark
//
//  Created by fabian zarate on 28/01/2023.
//

import UIKit
import Combine
import CoreLocation

final class ResultadoBusquedaViewController: BaseViewController {

    @IBOutlet private var headerViews: [UIView]!
    @IBOutlet weak var viewPageController: UIView!
        
    private let pageViewController: BasePageViewController
    private let page: Int
    
    init(page: Int = 0) {
        let controllers = [DestinoViewController(),
                           DuracionViewController(),
                           TuAutoViewController()]
    
        self.pageViewController = BasePageViewController(viewControllers: controllers, swipeEnabled: false)
        self.page = page
        super.init()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        pageViewController.setPage(page)
        updateHeader()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureNavigationBar()
        add(viewController: pageViewController, to: viewPageController)
    }

    private func configureNavigationBar() {
        let title = UIBarButtonItem.Custom.title(text: "Tu búsqueda")
        
        let back = UIBarButtonItem.Custom.image(image: .iconRowBack,
                                                target: self,
                                                action: #selector(backAction))
        
        navigationItem.leftBarButtonItems = [back, title]
    }
    
    @objc private func backAction() {
        guard !pageViewController.isFirstPage else {
            dismiss(animated: true)
            return
        }
        
        pageViewController.previousPage()
        updateHeader()
    }
    
    private func showAllSetController() {
        let vc = TodoListoBusquedaViewController()
        navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func btnContinuar(_ sender: IziButton) {
        guard !pageViewController.isLastPage else {
            showAllSetController()
            return
        }
        
        pageViewController.nextPage()
        updateHeader()
    }
    
    private func updateHeader() {
        for view in headerViews {
            UIView.animate(withDuration: 0.5, animations: { [weak self] in
                guard let self = self else { return }
                let enable = view.tag <= self.pageViewController.page
                
                if let label = view as? UILabel {
                    label.textColor = enable ? .black : .disabled
                } else {
                    view.backgroundColor = enable ? .primary : .disabled
                }
            })
        }
    }
}
