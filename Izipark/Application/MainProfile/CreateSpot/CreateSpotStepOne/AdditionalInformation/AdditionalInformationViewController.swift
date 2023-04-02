//
//  AdditionalInformationViewController.swift
//  Izipark
//
//  Created by fabian zarate on 28/03/2023.
//

import UIKit

final class AdditionalInformationViewController: BaseViewController {

    @IBOutlet weak var textPlaceholder: UILabel!
    @IBOutlet weak var textDescription: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        textDescription.delegate = self
    }

}

extension AdditionalInformationViewController : UITextViewDelegate {
    func textViewDidChange(_ textView: UITextView) {
        textPlaceholder.isHidden = !textView.text.isEmpty
    }
}
