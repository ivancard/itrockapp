//
//  VerifySpotViewController.swift
//  Izipark
//
//  Created by ivan cardenas on 30/01/2023.
//

import UIKit

final class VerifySpotViewController: BaseViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet weak var spotImage: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    @IBAction func continueButton(_ sender: Any) {
        self.navigationController?.pushViewController(SuccessSpotVerificationViewController(), animated: true)
    }
    
    @IBAction func openGallery(_ sender: UIButton) {
        self.showImagePicker(selectedSource: .photoLibrary)
    }
    
    @IBAction func openCamera(_ sender: Any) {
        self.showImagePicker(selectedSource: .camera)
    }
    func showImagePicker(selectedSource: UIImagePickerController.SourceType) {
        guard UIImagePickerController.isSourceTypeAvailable(selectedSource) else {
            print("Selected source not available")
            return
        }
        let imagePickerController = UIImagePickerController()
        imagePickerController.delegate = self
        imagePickerController.sourceType = selectedSource
        imagePickerController.allowsEditing = false
        self.present(imagePickerController, animated: true)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let selectedImage = info[.originalImage] as? UIImage {
            spotImage.image = selectedImage
        } else {
            print("image not found")
        }
        picker.dismiss(animated: true)
    }
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true)
    }
}
