//
//  LostObjectDescriptionViewController.swift
//  Izipark
//
//  Created by fabian zarate on 20/03/2023.
//

import UIKit

final class LostObjectDescriptionViewController: BaseViewController {

    @IBOutlet weak var placeholderDescription: UILabel!
    @IBOutlet weak var descriptionLostObject: UITextView!
    @IBOutlet weak var sendDescription: IziButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.leftBarButtonItem = .Custom.title(text: "Perdí un objeto")
        descriptionLostObject.delegate = self
    }
    
    @IBAction func sendDescriptionAction(_ sender: Any) {
        let vc = SuccesfulActionViewController(
            titleButton: "Volver a mi perfil",
            textMessage: "Tu mensaje ha sido enviado exitosamente") {
                let vc = TabBarController()
                vc.indexTabBar = .profile
                NavigationHelper.setRoot(viewController: vc, animated: true)
            }
        
        navigationController?.pushViewController(vc, animated: true)
    }
}

extension LostObjectDescriptionViewController:  UITextViewDelegate {
    func textViewDidChange(_ textView: UITextView) {
        UIView.animate(withDuration: 0.4) {
            self.placeholderDescription.isHidden = !textView.text.isEmpty
        }
        print(!textView.text.isEmpty as Any)
        sendDescription.isValid = !textView.text.isEmpty
        sendDescription.awakeFromNib()
    }
}
