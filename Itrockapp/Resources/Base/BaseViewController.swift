//
//  BaseViewController.swift
//  Itrockapp
//
//  Created by Ivan Cardenas on 22/12/2022.
//

import UIKit
import Combine
import SVProgressHUD

class BaseViewController: UIViewController, AlertableViewController, LoadableViewController {
        
    @Published var loading: Bool = false
    
    var cancellables = Set<AnyCancellable>()
    var hidesNavigationBar: Bool = false
    
    init(nibName: String? = nil) {
        let name = String(describing: type(of: self))
        super.init(nibName: nibName ?? name, bundle: nil)
        modalPresentationStyle = .fullScreen
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        modalPresentationStyle = .fullScreen
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(hidesNavigationBar, animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.backButtonTitle = ""
        navigationItem.leftItemsSupplementBackButton = true
        
        $loading
            .receive(on: DispatchQueue.main)
            .sink(receiveValue: { [weak self] show in
                self?.showHUD(show)
            })
            .store(in: &cancellables)
    }
    
    func configItemTabBar(nameTitle : String, image : UIImage){
        self.tabBarItem.title = nameTitle
        self.tabBarItem.image = image
    }
    
    func present(_ viewControllerToPresent: UIViewController, animated flag: Bool, embedNavigation: Bool = false, completion: (() -> Void)? = nil) {
        if embedNavigation {
            let navigationController = UINavigationController(rootViewController: viewControllerToPresent)
            navigationController.modalPresentationStyle = .fullScreen
            present(navigationController, animated: flag)
        } else {
            present(viewControllerToPresent, animated: flag)
        }
    }

}

protocol AlertableViewController {}

extension AlertableViewController where Self: UIViewController {
        
    func showError(_ error: Error? = nil, dismissAction: (() -> Void)? = nil) {
        let appName = Bundle.main.object(forInfoDictionaryKey: "CFBundleDisplayName") as? String ?? ""
        let message = error?.localizedDescription ?? "Algo salió mal.. Intentá de nuevo mas tarde."
        
        let alertController = UIAlertController(
            title           : appName,
            message         : message,
            preferredStyle  : .alert
        )
        
        alertController.addAction(UIAlertAction(
            title   : "Cerrar",
            style   : UIAlertAction.Style.cancel,
            handler : { [weak self] _ in
                dismissAction?()
                self?.dismiss(animated: true)
            }
        ))
        
        self.present(alertController, animated: true, completion: nil)
    }
    
    func showError(_ error: String?, dismissAction: (() -> Void)? = nil) {
        
        let alertController = UIAlertController(
            title           : error,
            message         : "Volver a intentar.",
            preferredStyle  : .alert
        )
        
        alertController.addAction(UIAlertAction(
            title   : "Cerrar",
            style   : UIAlertAction.Style.cancel,
            handler : { [weak self] _ in
                dismissAction?()
                self?.dismiss(animated: true)
            }
        ))
        self.present(alertController, animated: true, completion: nil)
    }
    
    func showAlert(title: String? = nil, message: String?, showCancel: Bool = false, completion: (() -> Void)? = nil) {
        let appName = Bundle.main.object(forInfoDictionaryKey: "CFBundleDisplayName") as? String ?? ""

        let alertController = UIAlertController(
            title           : title ?? appName,
            message         : message,
            preferredStyle  : .alert
        )
        
        if showCancel {
            alertController.addAction(UIAlertAction(
                title   : "Cancelar",
                style   : UIAlertAction.Style.cancel,
                handler : { [weak self] _ in self?.dismiss(animated: true) }
            ))
        }
        
        alertController.addAction(UIAlertAction(
            title   : "Aceptar",
            style   : UIAlertAction.Style.default,
            handler : { _ in completion?() }
        ))
        
        self.present(alertController, animated: true, completion: nil)
    }
}

protocol LoadableViewController {}

extension LoadableViewController {
    func showHUD(_ show: Bool, message: String? = nil) {
        SVProgressHUD.setDefaultMaskType(.gradient)
        
        DispatchQueue.main.asyncAfter(deadline: .now()) {
            if show {
                SVProgressHUD.show(withStatus: message)
            } else {
                SVProgressHUD.dismiss()
            }
        }
    }
}
