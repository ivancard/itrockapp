//
//  SuccesfulActionViewController.swift
//  Izipark
//
//  Created by fabian zarate on 20/03/2023.
//

import UIKit

final class SuccesfulActionViewController: BaseViewController {

    @IBOutlet weak var buttonAction: IziButton!
    @IBOutlet weak var message: UILabel!
    
    private var titleButton : String?
    private var textMessage : String?
    private var btnAction: (()->Void)?
    
    init( titleButton: String? = nil, textMessage: String? = nil, btnAction: (()->Void)? = nil) {
        self.titleButton = titleButton
        self.textMessage = textMessage
        self.btnAction = btnAction
        super.init()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.setNavigationBarHidden(true, animated: true)
        self.message.text = textMessage
        buttonAction.setTitle(titleButton, for: [])
    }

    @IBAction func btnAction(_ sender: Any) {
        btnAction?()
    }
}
