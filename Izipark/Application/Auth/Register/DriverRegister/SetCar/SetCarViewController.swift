//
//  SetCarViewController.swift
//  Izipark
//
//  Created by ivan cardenas on 22/12/2022.
//

import UIKit

enum SetCarType {
    case firstCar
    case newCar
    case myCar
}


final class SetCarViewController: BaseViewController {

    @IBOutlet weak var selectCarBrand: UIButton!
    @IBOutlet weak var selectCarModel: UIButton!
    @IBOutlet weak var selectCarColor: UIButton!
    @IBOutlet weak var imageContainer: UIImageView!
    @IBOutlet weak var patenteTextField: IziTextField!
    @IBOutlet weak var colorDropIcon: UIImageView!

    var brand: String?
    var model: String?
    var color: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setPopUpCarBrand()
        setPopUpCarModel()
        setPopUpCarColor()
        
        navigationItem.leftBarButtonItem = UIBarButtonItem.Custom.title(text: "Agregar nuevo auto")
    }

    func setPopUpCarBrand(){
        let optionClosure = {(action: UIAction) in
            self.brand = action.title
            self.setPopUpCarModel()
        }
        selectCarBrand.menu = UIMenu(children:[
            UIAction(title: "Marca", state: .on ,handler: optionClosure),
                UIAction(title: "Nissan", handler: optionClosure),
                UIAction(title: "Chevrolet", handler: optionClosure),
                UIAction(title: "Ford", handler: optionClosure)
        ])
        selectCarBrand.showsMenuAsPrimaryAction = true
        if #available(iOS 15.0, *) {
            selectCarBrand.changesSelectionAsPrimaryAction = true
        } else {
            // Fallback on earlier versions
        }
    }
    
    func setPopUpCarModel(){
        let optionClosure = {(action: UIAction) in
            self.model = action.title
            self.setPopUpCarColor()
        }
        
        switch self.brand {
        case "Nissan":
            selectCarModel.menu = UIMenu(children:[
                UIAction(title: "Modelo", state: .on ,handler: optionClosure),
                    UIAction(title: "Leaf", handler: optionClosure),
                    UIAction(title: "Versa", handler: optionClosure),
                    UIAction(title: "Sentra", handler: optionClosure)
            ])
        case "Chevrolet":
            selectCarModel.menu = UIMenu(children:[
                UIAction(title: "Modelo", state: .on ,handler: optionClosure),
                    UIAction(title: "Onix", handler: optionClosure),
                    UIAction(title: "Tracker", handler: optionClosure),
                    UIAction(title: "Prisma", handler: optionClosure)
            ])
        case "Ford":
            selectCarModel.menu = UIMenu(children:[
                UIAction(title: "Modelo", state: .on ,handler: optionClosure),
                    UIAction(title: "Focus", handler: optionClosure),
                    UIAction(title: "Fiesta", handler: optionClosure),
                    UIAction(title: "Ranger", handler: optionClosure)
            ])
        default:
            selectCarModel.menu = UIMenu(children:[
                UIAction(title: "Modelo", state: .on ,handler: optionClosure),
                    UIAction(title: "Leaf", handler: optionClosure),
                    UIAction(title: "Leaf", handler: optionClosure),
                UIAction(title: "Leaf", handler: optionClosure)])
        }
        
        selectCarModel.showsMenuAsPrimaryAction = true
        if #available(iOS 15.0, *) {
            selectCarModel.changesSelectionAsPrimaryAction = true
        } else {
            // Fallback on earlier versions
        }
    }

    func setPopUpCarColor(){
        let optionClosure = {(action: UIAction) in
            self.color = action.title
            self.showCar(modelName: self.model!)
        }
        selectCarColor.menu = UIMenu(children:[
            UIAction(title: "Color", state: .on ,handler: optionClosure),
            UIAction(title: "Black", handler: optionClosure),
            UIAction(title: "White", handler: optionClosure),
            UIAction(title: "Grey", handler: optionClosure)
        ])
        selectCarColor.showsMenuAsPrimaryAction = true
        if #available(iOS 15.0, *) {
            selectCarColor.changesSelectionAsPrimaryAction = true
        } else {
            // Fallback on earlier versions
        }
    }
        
    func showCar(modelName: String) {
        if modelName != "Modelo"{
            self.selectCarColor.isHidden = true
            self.colorDropIcon.isHidden = true
            self.imageContainer.isHidden = false

            self.imageContainer.layer.compositingFilter = "multiplyBlendMode"
            self.imageContainer.image = UIImage(named: self.model ?? "leaf")
        } else {
            self.imageContainer.isHidden = true
        }
    }
    

    @IBAction func continueButton(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
}
