//
//  InputDropDown.swift
//  Izipark
//
//  Created by fabian zarate on 01/02/2023.
//

import Foundation
import UIKit
import Combine

class InputDropDown: UIView {
    
    let nibName = "InputDropDown"
    
    @IBOutlet weak var carView: CardView!
    @IBInspectable private var placeHolder: String = ""
    @IBInspectable private var hideDropDown: Bool = false
    @IBOutlet weak var btnDropDown: UIButton!
    @IBOutlet weak var input: UITextField!
    var listString = [String]()
    var observable = PassthroughSubject<Void,Error>()
    
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
        self.input.placeholder = placeHolder
        self.btnDropDown.isHidden = hideDropDown
        input.addTarget(self, action: #selector(handleTextChange), for: .editingChanged)
        setUpButtonMenu()
    }
    
    func setUpButtonMenu(){
        
        let optionClosure = {(action: UIAction) in
            self.input.text = action.title
            self.handleTextChange()
        }
        
        let menuChildren = listString.map { string in
            UIAction(title: string, handler: optionClosure)
        }
        
        btnDropDown.menu = UIMenu(children: menuChildren)
        
        btnDropDown.showsMenuAsPrimaryAction = true
    }
    
    @objc  fileprivate func  handleTextChange(){
        guard let text = input.text else {return}
        
        if !text.isEmpty {
            UIView.animate(withDuration: 0, animations: {
                self.btnDropDown.setImage(UIImage.iconDropDownBlack, for: .normal)
            })
        }else{
            UIView.animate(withDuration: 0, animations: {
                self.btnDropDown.setImage(UIImage.iconDropDownGray, for: .normal)
            })
        }
        self.observable.send()
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
