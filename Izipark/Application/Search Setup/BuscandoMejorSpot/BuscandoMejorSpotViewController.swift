//
//  BuscandoMejorSpotViewController.swift
//  Izipark
//
//  Created by fabian zarate on 03/02/2023.
//

import UIKit
import MapboxCommon

final class BuscandoMejorSpotViewController: BaseViewController {
    
    @IBOutlet weak private  var textLoad: UILabel!
    @IBOutlet weak private  var imageLoad: UIImageView!
    
    private let arrayTextLoad: [String]
    private var animationCount = 0
    
    var onCompletion: (()->Void)?
    
//    "Si lo deseas puedes modificar tu radio de búsqueda",
//    "Si el Spot continua disponible podrás agregar más tiempo",
//    "Hay más de 5000 spots disponibles en toda la ciudad",
//    "“El spot puede estar ocupado” *",
//   "..."
    init(text: [String] = ["Utilizar Spots sin autorización puede provocar multas"], onCompletion: (()->Void)? = nil) {
        self.arrayTextLoad = text
        self.onCompletion = onCompletion
        super.init()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        hidesNavigationBar = true
        textLoad.text = arrayTextLoad [animationCount]
        CABasicAnimation.rotation.delegate = self
        imageLoad.layer.add(CABasicAnimation.rotation, forKey: nil)
    }
}

extension BuscandoMejorSpotViewController:  CAAnimationDelegate {
    func animationDidStop(_ anim: CAAnimation, finished flag: Bool) {
        if animationCount < arrayTextLoad.count {
            imageLoad.layer.add(CABasicAnimation.rotation, forKey: nil)
            textLoad.text = arrayTextLoad [animationCount]
        } else {
            dismiss(animated: true) { [weak self] in
                self?.onCompletion?()
            }
        }
        
        animationCount += 1
    }
}
