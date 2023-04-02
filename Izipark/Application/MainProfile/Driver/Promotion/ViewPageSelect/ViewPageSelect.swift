//
//  ViewPageSelect.swift
//  Izipark
//
//  Created by fabian zarate on 06/03/2023.
//

import Foundation
import UIKit

class ViewPageSelect: UIView {
    
    let nibName = "ViewPageSelect"
    
    @IBInspectable  var isDisponible : Bool = false {
        didSet {
            setUpView(isDisponible)
        }
    }
    
    
    @IBOutlet weak private var viewCircular: UIView!
    @IBOutlet weak private var text: UILabel!
    @IBOutlet weak private var line: UIView!
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        setUpView(isDisponible)
        self.text.text = isDisponible ? "Disponibles" : "No disponibles"
    }
    
    private func setUpView(_ isDiponible : Bool){
        UIView.animate(withDuration: 0.4) {
            self.line.isHidden = !isDiponible
            self.text.textColor = isDiponible ? .black : .disabled
            self.viewCircular.backgroundColor = isDiponible ? .black : .disabled
        }
    }
    
    func commonInit() {
        guard let view = loadViewFromNib() else { return }
        view.frame = self.bounds
        self.addSubview(view)
    }
    
    func loadViewFromNib() -> UIView? {
        let nib = UINib(nibName: nibName, bundle: nil)
        return nib.instantiate(withOwner: self, options: nil).first as? UIView
    }
    
}
