//
//  HelpPhotoViewController.swift
//  Izipark
//
//  Created by fabian zarate on 20/03/2023.
//

import UIKit

final class HelpPhotoViewController: BaseViewController{
    
    private var photoFileSelectionActionSheet : PhotoFileSelectionActionSheet!

    @IBOutlet weak var btnTakePhoto: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Ayuda con la estadía en curso"
        photoFileSelectionActionSheet = PhotoFileSelectionActionSheet().configure(viewController: self,
                                                    pickerDelegate: self)
    }

    @IBAction func takePhotoAction(_ sender: Any) {
        photoFileSelectionActionSheet.takePhotoFromCamera()
    }
}
extension HelpPhotoViewController: PhotoFileSelectionActionSheetDelegate {
    func imageSelected(image: UIImage?) {
        
        let vc = SuccesfulActionViewController(titleButton: "Volver a mi perfil", textMessage: "Tu auto ha sido cargado exitosamente") {
            let vc = TabBarController()
            vc.indexTabBar = .profile
            NavigationHelper.setRoot(viewController: vc, animated: true)
        }

        NavigationHelper.setRoot(viewController: vc, animated: true)
    }
}
