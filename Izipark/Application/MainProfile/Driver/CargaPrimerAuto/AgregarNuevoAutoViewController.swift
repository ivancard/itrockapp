//
//  AgregarNuevoAutoViewController.swift
//  Izipark
//
//  Created by fabian zarate on 01/02/2023.
//

import UIKit
import Combine

final class AgregarNuevoAutoViewController: BaseViewController {
    
    
    var brand = ["Fiat","Chevrolet", "Nissan","Ford"]
    var model = ["Palio","Classic","Estrada", "Focus"]
    var colors = ["Rojo","Negro","Amarillo","Verde"]
    
    @IBOutlet weak var viewDescription: UIView!
    @IBOutlet weak var imageCar: UIImageView!
    @IBOutlet weak var inputPatent: InputDropDown!
    @IBOutlet weak var inputColor: InputDropDown!
    @IBOutlet weak var inputModel: InputDropDown!
    @IBOutlet weak var inputBrand: InputDropDown!
    @IBOutlet weak var inputDropDown: InputDropDown!
    
    @IBOutlet weak var btnContinuar: IziButton!
    @IBOutlet weak var btnDeleteCar: UIButton!
    
    private var anyCancellable = Set<AnyCancellable>()
    private var carType : SetCarType = .newCar
    private let pageDestino = 2
    
    init(setCarType : SetCarType) {
        carType = setCarType
        super.init()
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tabBarController?.tabBar.isHidden = true
        setUpCarType()
        loadListInputs()
        suscription()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        tabBarController?.tabBar.isHidden = false
    }
    
    private func loadListInputs(){
        inputBrand.listString = brand
        inputModel.listString = model
        inputColor.listString = colors
    }
    
    private func  setUpCarType() {
        
        switch carType {
        case .myCar :
                setMyCar()
        case .newCar :
                setNewCar()
        case .firstCar:
            return
        }
    }
    
    private func setMyCar(){
        navigationItem.leftBarButtonItem = .Custom.title(text: "Mis autos")
        viewDescription.isHidden = true
        imageCar.isHidden = false
        
        inputBrand.input.text = "Fiat"
        inputModel.input.text = "Palio"
        inputColor.input.text = "Azul"
        inputPatent.input.text = "FCD 309"
        
    }
    
    private func setNewCar(){
        navigationItem.leftBarButtonItem = .Custom.title(text: "Agregar nuevo auto")
        btnDeleteCar.isHidden = true
        imageCar.isHidden = true
    }
    
    private func suscription(){
        
        inputColor.observable.sink { error in
            print (error)
        } receiveValue: {
            self.requestImageCar()
            self.validateInput()
        }.store(in: &anyCancellable)
        
        inputModel.observable.sink { error in
            print (error)
        } receiveValue: {
            self.requestImageCar()
            self.validateInput()
        }.store(in: &anyCancellable)
        
        inputBrand.observable.sink { error in
            print (error)
        } receiveValue: {
            self.requestImageCar()
            self.validateInput()
        }.store(in: &anyCancellable)
        
        inputPatent.observable.sink { error in
            print (error)
        } receiveValue: {
            self.requestImageCar()
            self.validateInput()
        }.store(in: &anyCancellable)

    }
    
    func validateInput(){
        
        if !inputColor.input.text!.isEmpty &&
            !inputBrand.input.text!.isEmpty &&
            !inputPatent.input.text!.isEmpty &&
            !inputModel.input.text!.isEmpty  {
            
            btnContinuar.isValid = true
            
        }else {

            btnContinuar.isValid = false
        }
        btnContinuar.awakeFromNib()
    }
    
    func requestImageCar(){
        
        if !inputColor.input.text!.isEmpty &&
                !inputBrand.input.text!.isEmpty &&
                !inputModel.input.text!.isEmpty  {
            self.imageCar.isHidden = false
        }else {
            self.imageCar.isHidden = true
        }
    }
    
    @IBAction func btnContinuarAction(_ sender: Any) {
        let vc = AutoCargadoExitosamenteViewController()
        NavigationHelper.setRoot(viewController: vc, animated: true)
    }
    
    @IBAction func deleteCarAction(_ sender: Any) {
        let popup = PopupViewController(
            title: "Eliminar mi auto",
            subtitle: "¿Deseas eliminar este auto?",
            secondaryButtonItem: .init(title: "No", action: { [weak self] in
                self?.dismiss(animated: true)
            }),
            primaryButtonItem: .init(title: "Si, eliminar",
                                     action: { [weak self] in
                                         self?.dismiss(animated: true)
                                         self?.navigationController?.popViewController(animated: true)
                                     }))
        popup.show(on: self)
    }
}
