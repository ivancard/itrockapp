//
//  BasePopup.swift
//  Itrockapp
//
//  Created by Ivan Cardenas on 18/01/2023.
//
import Foundation
import UIKit

class BasePopup: BaseViewController {
    
    enum ShowDirection {
        case top, left, right, bottom
    }
    
    var showDirection: ShowDirection = .bottom
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .black.withAlphaComponent(0.5)
        
        let backgroundView = UIView()
        backgroundView.translatesAutoresizingMaskIntoConstraints = false
        backgroundView.backgroundColor = .clear
        view.insertSubview(backgroundView, at: 0)
        
        NSLayoutConstraint.activate([
            backgroundView.topAnchor.constraint(equalTo: view.topAnchor),
            backgroundView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            backgroundView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            backgroundView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        
        backgroundView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(backgroundTapAction)))
        
        prepareForModalPresentation()
    }
    
    private func prepareForModalPresentation() {
        self.providesPresentationContextTransitionStyle = true
        self.definesPresentationContext = true
        self.modalPresentationStyle = .overFullScreen
    }
    
    @objc private func backgroundTapAction() {
        dismiss()
    }
    
    private func hide() {
        view.subviews.forEach {
            let x = showDirection == .left ? -view.frame.width : showDirection == .right ? view.frame.width : 0
            let y = showDirection == .top ? -view.frame.width : showDirection == .bottom ? view.frame.height : 0
            
            $0.transform = .init(translationX: x, y: y)
        }
    }
    
    func show(on viewController: UIViewController? = nil, from direction: ShowDirection = .bottom) {
        guard let viewController = viewController ?? UIViewController.getTopViewController() else { return }
        self.showDirection = direction
        hide()
        
        viewController.present(self, animated: false, completion: {
            UIView.animate(withDuration: 0.4,
                           delay: 0,
                           usingSpringWithDamping: 0.8,
                           initialSpringVelocity: 0.5,
                           animations: { [weak self] in
                self?.view.subviews.forEach {
                    $0.transform = .identity
                }
            })
        })
    }
    
    func dismiss(_ completion: (()->Void)? = nil) {
        UIView.animate(withDuration: 0.4,
                       animations: { [weak self] in
            self?.hide()
        }, completion: { [weak self] _ in
            self?.dismiss(animated: false, completion: {
                completion?()
            })
        })
    }
}
