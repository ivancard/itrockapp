
//  FileSelectionActionSheet.swift
//  Celebrastic
//
//  Created by Admin on 21/3/16.
//  Copyright © 2016 Infinixsoft. All rights reserved.
//

import UIKit
import MobileCoreServices

protocol PhotoPickerDelegate: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
}

protocol PhotoFileSelectionActionSheetDelegate : AnyObject {
    
    func imageSelected(image:UIImage?)
    
}

class PhotoFileSelectionActionSheet : NSObject, UIActionSheetDelegate {
    
    
    weak var viewController:UIViewController?
    
    weak var pickerDelegate:PhotoFileSelectionActionSheetDelegate?
    
    var actVC: UIAlertController?
    
    
    static func show(on viewController: UIViewController, pickerDelegate:PhotoFileSelectionActionSheetDelegate?, allowRemoval: Bool = false){
        
        PhotoFileSelectionActionSheet()
            .configure(viewController: viewController, pickerDelegate: pickerDelegate)
            .selectFile(allowRemoval: allowRemoval)
    }
    
    func configure(viewController:UIViewController,pickerDelegate:PhotoFileSelectionActionSheetDelegate?) -> PhotoFileSelectionActionSheet {
        
        self.viewController = viewController
        self.pickerDelegate = pickerDelegate
        
        return self
    }
    
    func selectFile(allowRemoval: Bool) {
        
        self.actVC = UIAlertController (title: nil, message: nil, preferredStyle: .actionSheet)
        
        let removeAc = UIAlertAction (title: "Borrar", style: .default)
        { (action) in self.pickerDelegate?.imageSelected(image: nil) }

        let takePhotoAc = UIAlertAction (title: "Tomar foto", style: .default)
        { (action) in self.takePhotoFromCamera() }
        
        let selectVC = UIAlertAction (title: "Abrir galería", style: .default)
        { (action) in self.takePhotoFromGallery() }
        
        let cancelButton = UIAlertAction (title: "Cancelar", style: .cancel, handler: nil)

        if allowRemoval {
            actVC?.addAction(removeAc)
        }
        
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            actVC?.addAction(takePhotoAc)
        }
        
        if UIImagePickerController.isSourceTypeAvailable(.photoLibrary) {
            actVC?.addAction(selectVC)
        }
        
        actVC?.addAction(cancelButton)
        
        self.viewController?.present(actVC!, animated: true, completion: nil)
    }
    
    func takePhotoFromCamera() {
        
        let picker = UIImagePickerController()
        picker.delegate = self
        picker.mediaTypes = [String(kUTTypeImage)]
        picker.sourceType = .camera
        picker.cameraDevice = .rear
        picker.allowsEditing = true
        
        viewController?.present(picker, animated: true, completion: nil)
    }
    
    func takePhotoFromGallery(){
        let picker = UIImagePickerController()
        picker.delegate = self
        picker.mediaTypes = [String(kUTTypeImage)]
        picker.sourceType = UIImagePickerController.SourceType.photoLibrary
        picker.allowsEditing = true
        
        viewController?.present(picker, animated: true, completion: nil)
    }
    
    func dismissPicker(picker: UIImagePickerController) {
        
        picker.dismiss(animated: true, completion: nil)
        self.actVC = nil
    }
    
}

extension PhotoFileSelectionActionSheet : PhotoPickerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        // Local variable inserted by Swift 4.2 migrator.
        let info = convertFromUIImagePickerControllerInfoKeyDictionary(info)
        
        
        var image = info[convertFromUIImagePickerControllerInfoKey(UIImagePickerController.InfoKey.editedImage)] as? UIImage
        
        if image == nil {
            image = info[convertFromUIImagePickerControllerInfoKey(UIImagePickerController.InfoKey.originalImage)] as? UIImage
        }
        
        self.pickerDelegate?.imageSelected(image: image)
        
        
        
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        
        NavigationHelper.setRoot(viewController: HelpPhotoViewController(), animated: true)
        
//        self.dismissPicker(picker: picker)
        
    }
}

// Helper function inserted by Swift 4.2 migrator.
fileprivate func convertFromUIImagePickerControllerInfoKeyDictionary(_ input: [UIImagePickerController.InfoKey: Any]) -> [String: Any] {
    return Dictionary(uniqueKeysWithValues: input.map {key, value in (key.rawValue, value)})
}

// Helper function inserted by Swift 4.2 migrator.
fileprivate func convertFromUIImagePickerControllerInfoKey(_ input: UIImagePickerController.InfoKey) -> String {
    return input.rawValue
}

extension UIImagePickerController {
    open override var childForStatusBarHidden: UIViewController? {
        return nil
    }
    
    open override var prefersStatusBarHidden: Bool {
        return true
    }
    
    open override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        fixCannotMoveEditingBox()
    }
    
    func fixCannotMoveEditingBox() {
        if let cropView = cropView,
           let scrollView = scrollView,
           scrollView.contentOffset.y == 0 {
            
            var top: CGFloat = 0.0
            if #available(iOS 11.0, *) {
                top = cropView.frame.minY + self.view.safeAreaInsets.top
            } else {
                // Fallback on earlier versions
                top = cropView.frame.minY
            }
            let bottom = scrollView.frame.height - cropView.frame.height - top
            scrollView.contentInset = UIEdgeInsets(top: top, left: 0, bottom: bottom, right: 0)
            
            var offset: CGFloat = 0
            if scrollView.contentSize.height > scrollView.contentSize.width {
                offset = 0.5 * (scrollView.contentSize.height - scrollView.contentSize.width)
            }
            scrollView.contentOffset = CGPoint(x: 0, y: -top + offset)
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) { [weak self] in
            self?.fixCannotMoveEditingBox()
        }
    }
    
    var cropView: UIView? {
        return findCropView(from: self.view)
    }
    
    var scrollView: UIScrollView? {
        return findScrollView(from: self.view)
    }
    
    func findCropView(from view: UIView) -> UIView? {
        let width = UIScreen.main.bounds.width
        let size = view.bounds.size
        if width == size.height, width == size.height {
            return view
        }
        for view in view.subviews {
            if let cropView = findCropView(from: view) {
                return cropView
            }
        }
        return nil
    }
    
    func findScrollView(from view: UIView) -> UIScrollView? {
        if let scrollView = view as? UIScrollView {
            return scrollView
        }
        for view in view.subviews {
            if let scrollView = findScrollView(from: view) {
                return scrollView
            }
        }
        return nil
    }
}
