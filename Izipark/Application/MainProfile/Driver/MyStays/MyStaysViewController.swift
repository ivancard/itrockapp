//
//  MyStaysViewController.swift
//  Izipark
//
//  Created by fabian zarate on 27/02/2023.
//

import UIKit

final class MyStaysViewController: BaseViewController {
    
    @IBOutlet weak var myStaysTableView: UITableView!
    
    private let month = ["Marzo", "Febero","Enero"]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.leftBarButtonItem = .Custom.title(text: "Mis Estadias")
        tabBarController?.tabBar.isHidden = true
        
        myStaysTableView.contentInset = UIEdgeInsets(top: 16, left: 0, bottom: 80, right: 0)
        myStaysTableView.registerFromClass(headerFooterView: MyStaysHeader.self)
        myStaysTableView.configure(delegate: self, dataSource: self, cells: [MyStayCell.self])
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        tabBarController?.tabBar.isHidden = false
    }
}

extension MyStaysViewController : UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        month.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeue(cellType: MyStayCell.self)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard let sectionView = tableView.dequeueReusableHeaderFooterView(withIdentifier: "\(MyStaysHeader.self)") as? MyStaysHeader else{
            return nil
        }
        sectionView.title.text = month[section]
        sectionView.configView()
        return sectionView
    }


}
