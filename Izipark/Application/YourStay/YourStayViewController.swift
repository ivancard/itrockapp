//
//  YourStayViewController.swift
//  Izipark
//
//  Created by fabian zarate on 17/02/2023.
//

import UIKit

final class YourStayViewController: BaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        configureNavigationBar()
    }
    
    private func configureNavigationBar() {
        let back = UIBarButtonItem.Custom.image(image: .iconRowBack,
                                                target: self,
                                                action: #selector(backAction))
        
        let title = UIBarButtonItem.Custom.title(text: "Tu estadía")

        navigationItem.leftBarButtonItems =  [back, title]
    }

    @objc func backAction(){
    }
    
}
