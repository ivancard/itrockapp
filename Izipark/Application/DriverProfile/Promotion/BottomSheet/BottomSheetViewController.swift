//
//  BottomSheetViewController.swift
//  Izipark
//
//  Created by fabian zarate on 21/03/2023.
//

import UIKit

final class BottomSheetViewController: UIViewController {

    @IBOutlet weak var overlayView: UIView!
    @IBOutlet weak var sharedContainer: CardView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        let leftSwipe = UISwipeGestureRecognizer(target: self, action: #selector(self.swipeAction(swipe:)))
        leftSwipe.direction = UISwipeGestureRecognizer.Direction.down
        sharedContainer.addGestureRecognizer(leftSwipe)
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(didTapOverlay(_:)))
        overlayView.addGestureRecognizer(tapGesture)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        sharedContainer.animateBottomSheet(show: true) {}
    }

    @objc func didTapOverlay(_ sender : UITapGestureRecognizer){
        sharedContainer.animateBottomSheet(show: false) {
            self.dismiss(animated: false)
        }
    }
    
    @objc func swipeAction(swipe: UISwipeGestureRecognizer) {
        sharedContainer.animateBottomSheet(show: false) {
            self.dismiss(animated: false)
        }
    }
}
