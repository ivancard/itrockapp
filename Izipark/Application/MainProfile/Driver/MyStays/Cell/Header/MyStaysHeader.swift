//
//  MyStaysHeader.swift
//  Izipark
//
//  Created by fabian zarate on 27/03/2023.
//

import UIKit

class MyStaysHeader: UITableViewHeaderFooterView {
    
    lazy var title : UILabel = {
        let label = UILabel()
        label.font = UIFont.Poppins.regular(withSize: 16)
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var lineView : UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(red: 0.851, green: 0.851, blue: 0.851, alpha: 1)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private var customView : UIView = {
        let view = UIView()
        view.backgroundColor = .clear
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configView() {
        contentView.addSubview(customView)
        
        NSLayoutConstraint.activate([
            customView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 29.0),
            customView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16.0),
            customView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            customView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            customView.heightAnchor.constraint(equalToConstant: 40.0),
        ])
        
        customView.addSubview(title)
        customView.addSubview(lineView)
        
        
        NSLayoutConstraint.activate([
            title.leadingAnchor.constraint(equalTo: customView.leadingAnchor, constant: 0),
            title.centerYAnchor.constraint(equalTo: customView.centerYAnchor),
        ])
        
        NSLayoutConstraint.activate([
            lineView.trailingAnchor.constraint(equalTo: customView.trailingAnchor, constant: 0),
            lineView.leadingAnchor.constraint(equalTo: title.trailingAnchor, constant: 70.0),
            lineView.centerYAnchor.constraint(equalTo: customView.centerYAnchor),
            lineView.heightAnchor.constraint(equalToConstant: 2.0),
        ])
    
        
    }
    
    
}


