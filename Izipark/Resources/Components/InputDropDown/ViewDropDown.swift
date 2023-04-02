//
//  ViewDropDown.swift
//  Izipark
//
//  Created by fabian zarate on 01/03/2023.
//

import UIKit

class ViewDropDown: UIStackView {
    
    lazy var tableView = {
        var tableView =  UITableView(frame: CGRect(x: 0, y: 0, width: 200, height: 100))
        
        return tableView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    func setup(){
        axis = .vertical
        alignment = .fill
        loadLayers()
    }
    
    private func loadLayers() {
        tableView.backgroundColor = .black
        
        addArrangedSubview(InputDropDown())
        addArrangedSubview(tableView)
    }
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
