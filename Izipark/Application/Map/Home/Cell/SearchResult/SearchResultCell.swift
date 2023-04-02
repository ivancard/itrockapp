//
//  SearchResultCell.swift
//  Izipark
//
//  Created by fabian zarate on 27/01/2023.
//

import UIKit
import MapboxSearch

final class SearchResultCell: UITableViewCell {

    @IBOutlet weak var nameLocation: UILabel!
    @IBOutlet weak var addressLocation: UILabel!
    
    func setup(with model: SpotSearchResultModel){
        nameLocation.text = model.title
        addressLocation.text = model.subtitle
        nameLocation.textColor = model.isFirst ? .black : .disabled
    }
}
