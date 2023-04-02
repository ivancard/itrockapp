//
//  TodoListoBusquedaViewController.swift
//  Izipark
//
//  Created by fabian zarate on 31/01/2023.
//

import UIKit
import Combine

final class TodoListoBusquedaViewController: BaseViewController {
    
    @IBOutlet weak private var btnBuscarSpot: IziButton!
    @IBOutlet weak private var titleView: UILabel!
    @IBOutlet weak private var editarAutoBtn: UIButton!
    @IBOutlet weak private var editarTiempoBtn: UIButton!
    @IBOutlet weak private var editarDestinoBtn: UIButton!
    @IBOutlet weak var yourDestiny: UILabel!
        
    private let hideEdit: Bool
    private let editStep: ((Int)->Void)?
    
    init(edit: Bool = false, editStep: ((Int)->Void)? = nil) {
        hideEdit = !edit
        self.editStep = editStep
        super.init()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        hideButtonsEdits(hideEdit)
        
        let title = "Todo listo para tu búsqueda"
        let editTitle = "Modifica tu búsqueda"
        titleView.text = hideEdit ? title : editTitle
        
        if ((SearchLocation.current?.address?.isEmpty) != nil) {
            yourDestiny.text = SearchLocation.current?.address
        }
        yourDestiny.text = SearchLocation.current?.name
        
        if !hideEdit {
            configureNavigationBar()
        }
    }
    
    private func configureNavigationBar() {
        let back = UIBarButtonItem.Custom.image(image: .iconRowBack,
                                                target: self,
                                                action: #selector(backAction))
        navigationItem.leftBarButtonItem =  back
    }
    
    @objc private func backAction() {
        dismiss(animated: true)
    }
    
    private func hideButtonsEdits(_ value : Bool){
        editarAutoBtn.isHidden = value
        editarTiempoBtn.isHidden = value
        editarDestinoBtn.isHidden = value
    }
 
    private func showSearchMap() {
        let vc = MapDetalleBusquedaViewController()
        let nc = UINavigationController(rootViewController: vc)
        NavigationHelper.setRoot(viewController: nc, animated: true)
    }
    
    @IBAction func editAction(_ sender: UIButton) {
        let vc = ResultadoBusquedaViewController(page: sender.tag)
        navigationController?.pushViewController(vc, animated: true)
        navigationController?.viewControllers.remove(at: 0)
    }
    
    @IBAction func btnBuscarSpotAction(_ sender: Any) {
        let vc = BuscandoMejorSpotViewController() { [weak self] in
            self?.showSearchMap()
        }
        present(vc, animated: true)
    }
}
