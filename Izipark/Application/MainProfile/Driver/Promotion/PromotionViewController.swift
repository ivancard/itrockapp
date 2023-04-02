//
//  PromotionViewController.swift
//  Izipark
//
//  Created by fabian zarate on 02/03/2023.
//

import UIKit

final class PromotionViewController: BaseViewController {
    
    @IBOutlet weak var btnDisponible: ViewPageSelect!
    @IBOutlet weak var btnNotDisponible: ViewPageSelect!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var btnShare: IziButton!
    
    var coupons = [Coupon]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.leftBarButtonItem = .Custom.title(text: "Promos")
        tabBarController?.tabBar.isHidden = true
        
        btnDisponible.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(disponibleAction)))
        btnNotDisponible.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(notDisponibleAction)))
       
        tableView.configure(delegate: self, dataSource: self,cells: [PromotionTableViewCell.self])
        
//        getCoupons()
    }
    
    private func setupGestureRecognizers() {
        
    }
    
    @IBAction func shareAction(_ sender: Any) {
        let vc = BottomSheetViewController()
        vc.modalPresentationStyle = .overCurrentContext
        
        present(vc, animated: false)
    }
    
    @objc func disponibleAction(){
        UIView.animate(withDuration: 0.4) {
            self.btnDisponible.isDisponible = true
            self.btnNotDisponible.isDisponible = false
        }
        print("disponible")
    }
    
    @objc func notDisponibleAction(){
        UIView.animate(withDuration: 0.4) {
            self.btnDisponible.isDisponible = false
            self.btnNotDisponible.isDisponible = true
        }
        print("not disponible")
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        tabBarController?.tabBar.isHidden = false
    }
    
}

extension PromotionViewController:  UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeue(cellType: PromotionTableViewCell.self)
        return cell
    }
}

extension PromotionViewController {
    private func getCoupons() {
        loading = true
        
        APIClient.User.GetCoupons(available: true)
            .dispatch()
            .sink(
                receiveCompletion: { [weak self] _ in
                    self?.loading = false
                },
                receiveValue: { [weak self] coupons in
                    self?.coupons = coupons
                    self?.tableView.reloadData()
                })
            .store(in: &cancellables)
    }
}
